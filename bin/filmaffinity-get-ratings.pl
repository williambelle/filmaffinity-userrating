#!/usr/bin/env perl

use strict;
use warnings;

use Getopt::Long;
use Pod::Usage;

use IO::All -utf8;
use FilmAffinity::Utils qw/data2tsv/;
use FilmAffinity::UserRating;

=head1 NAME - filmaffinity-get-ratings.pl

get ratings from filmaffinity for a user print them in Tab-separated values

=head1 SYNOPSIS

  ./filmaffinity-get-rating.pl --userid=123456
  
  ./filmaffinity-get-rating.pl --userid=123456 --delay=2
  
  ./filmaffinity-get-rating.pl --userid=123456 --output=/home/william/myvote.list

=head1 ARGUMENTS

=over 2

=item --userid=192076

userid from filmaffinity

=back

=head1 OPTIONS

=over 2

=item --delay=3

delay between requests

=item --output=/home/william/rating.list

output file

=back

=cut

my ( $userID, $delay, $output, $help );

GetOptions(
  "userid=i" => \$userID,
  "delay=i"  => \$delay,
  "output=s" => \$output,
  "help"     => \$help,
) 
|| pod2usage(2);

if ( $help || !$userID ) {
  pod2usage(1);
  exit(0);
}

my $userParser = FilmAffinity::UserRating->new( 
  userID => $userID,
  delay  => $delay || 5,
);

my $ref_movies = $userParser->parse();

my $tsv = data2tsv( $ref_movies );

$output ? $tsv > io($output) : print $tsv;
  

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