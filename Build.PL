use 5.006;
use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
  module_name       => 'FilmAffinity::UserRating',
  license           => 'perl',
  dist_author       => q{William Belle <william.belle@gmail.com>},
  dist_version_from => 'lib/FilmAffinity/UserRating.pm',
  build_requires    => {
    'Test::More'       => 0,
    'Test::JSON'       => 0.11,
    'File::Find::Rule' => 0.34,
    'Test::MockObject' => 1.20,
    'Test::LongString' => 0.17,
  },
  requires => {
    'perl'                     => 5.006,
    'Text::Trim'               => 1.02,
    'LWP::RobotUA'             => 6.36,
    'HTML::TreeBuilder'        => 5.07,
    'HTML::TreeBuilder::XPath' => 0.14,
    'Moose'                    => 2.20,
    'MooseX::Privacy'          => 0.05,
    'IO::All'                  => 0.87,
    'Encode'                   => 2.98,
    'JSON'                     => 2.97,
    'List::Compare'            => 0.53,
    'Readonly'                 => 2.05,
    'File::Copy::Recursive'    => 0.44,
    'IO::Interactive'          => 1.02,
  },
  meta_merge => {
    resources => {
      repository =>
        'https://github.com/williambelle/filmaffinity-userrating',
    },
  },
  add_to_cleanup     => ['FilmAffinity-UserRating-*'],
  create_makefile_pl => 'traditional',
);

$builder->create_build_script();
