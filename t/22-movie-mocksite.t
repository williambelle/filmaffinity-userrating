use strict;
use warnings;

use lib 't/';
use MockSite;

use JSON;
use IO::All;
use File::Basename;
use File::Find::Rule;
use FilmAffinity::Movie;

use Test::MockObject::Extends;
use Test::More tests => 4;

my @listMovies = File::Find::Rule->file()->name('*.html')->in(
  't/resources/filmaffinity-local-movie'
);

foreach my $movie (@listMovies){

  my ($id) = fileparse($movie, '.html');
  my $faMovie = FilmAffinity::Movie->new( id => $id);
  my $mock    = Test::MockObject::Extends->new( $faMovie );
  my $urlRoot = MockSite::mockLocalSite('t/resources/filmaffinity-local-movie');

  $mock->mock(
    'p_buildUrlMovie' => 
      sub {
        my ($self, $id) = @_; 
        return $urlRoot.'/'.$id.'.html';
      } 
  );

  $mock->parse();
  
  my $jsonContent < io('t/resources/json-movie/'.$id.'.json');
  my $jsonData = from_json( $jsonContent );
  
  is($faMovie->title(), $jsonData->{title}, 'title'); 
  is($faMovie->year(),  $jsonData->{year},  'year'); 
}
 
 __END__ 
  
is($faMovie->title(), 'The Matrix', 'same id');

warn @{$faMovie->composer()};
warn @{$faMovie->cast()};
warn $faMovie->website();
warn $faMovie->duration();
warn $faMovie->year();
warn @{$faMovie->genre()};
warn @{$faMovie->topic()};
warn @{$faMovie->studio()};
warn $faMovie->synopsis();
warn @{$faMovie->director()};
warn @{$faMovie->screenwriter()};
warn @{$faMovie->cinematographer()};
warn $faMovie->producer();