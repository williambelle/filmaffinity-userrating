#!/usr/bin/env perl

use strict;
use warnings;

use Getopt::Long;
use Pod::Usage;

use IO::All -utf8;

use FilmAffinity::Movie;

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

my $movieParser = FilmAffinity::Movie->new( 
  id    => $movieID,
  delay => $delay || 5,
);

$movieParser->parse();

my $json = $movieParser->toJSON();
$output ? $json > io($output) : print $json;