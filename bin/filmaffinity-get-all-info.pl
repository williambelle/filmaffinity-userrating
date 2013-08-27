#!/usr/bin/env perl

use strict;
use warnings;

use Getopt::Long;
use Pod::Usage;

use IO::All -utf8;
use FilmAffinity::Movie;
use FilmAffinity::Utils;
use FilmAffinity::UserRating;

=head1 NAME - filmaffinity-get-all-info.pl

get information from filmaffinity about a film and all ratings from a user

=head1 SYNOPSIS

  ./filmaffinity-get-all-info.pl --userid=123456
  
  ./filmaffinity-get-all-info.pl --userid=123456 --delay=2
  
  ./filmaffinity-get-all-info.pl --userid=123456 --

=head1 ARGUMENTS

=over 2

=item --userid=192076

userid from filmaffinity

=item --destination=/home/william/filmaffinity

destination folder

=back

=head1 OPTIONS

=over 2

=item --delay=3

delay between requests

=back

=cut

my ( $userID, $delay, $destination, $help );

GetOptions(
  "userid=i"      => \$userID,
  "delay=i"       => \$delay,
  "destination=s" => \$destination,
  "help"          => \$help,
) 
|| pod2usage(2);

if ( $help || !$userID || !$destination ) {
  pod2usage(1);
  exit(0);
}

mkdir $destination;
mkdir $destination.'/json';

my $userParser = FilmAffinity::UserRating->new( 
  userID => $userID,
  delay  => $delay || 5,
);
my $ref_movies = $userParser->parse();
my $tsv = data2tsv( $ref_movies );
$tsv > io($destination.'/ratings.list');

my $progress;
if ( -t STDOUT ) {
  eval {
    require Term::ProgressBar;
    $progress = Term::ProgressBar->new({ 
      name   => 'jsonize movie information', 
      count  => scalar keys %{$ref_movies}, 
      remove => 1 
    });
  };
  if ($@) {
    warn "Could not create progress bar. We can continue, but no progress will be reported";
  }
}

my $count = 0;
foreach my $id ( keys %{$ref_movies}){
  
  my $movie = FilmAffinity::Movie->new( 
    id    => $id,
    delay => $delay || 5,
  );
  $movie->parse();

  my $json = $movie->toJSON();
  $json > io($destination.'/json/'.$id.'.json'); 
  
  $count++;
  $progress->update($count) if $progress;    
}

=head1 AUTHOR

William Belle, C<< <william.belle at gmail.com> >>

=head1 SEE ALSO

L<http://www.filmaffinity.com>

=head1 LICENSE AND COPYRIGHT

Copyright 2013 William Belle.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut