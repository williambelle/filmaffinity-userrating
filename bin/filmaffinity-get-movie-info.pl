#!/usr/bin/env perl

use strict;
use warnings;

use Getopt::Long;
use Pod::Usage;

use IO::All -utf8;
use FilmAffinity::Movie;

=head1 NAME - filmaffinity-get-movie-info.pl

get information from filmaffinity about a film and print them in JSON formt

=head1 SYNOPSIS

  ./filmaffinity-get-movie-info.pl --id=123456
  
  ./filmaffinity-get-movie-info.pl --id=123456 --delay=2
  
  ./filmaffinity-get-movie-info.pl --id=932476 --output=/home/william/matrix.json

=head1 ARGUMENTS

=over 2

=item --id=932476

movie id from filmaffinity

=back

=head1 OPTIONS

=over 2

=item --delay=3

delay between requests

=item --output=/home/william/matrix.json

output json file

=back

=cut

my ( $movieID, $delay, $output, $help );

GetOptions(
  "id=i"     => \$movieID,
  "delay=i"  => \$delay,
  "output=s" => \$output,
  "help"     => \$help,
) 
|| pod2usage(2);

if ( $help || !$movieID ) {
  pod2usage(1);
  exit(0);
}

my $movie = FilmAffinity::Movie->new( 
  id    => $movieID,
  delay => $delay || 5,
);

$movie->parse();

my $json = $movie->toJSON();
$output ? $json > io($output) : print $json;

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