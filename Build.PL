use 5.006;
use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'FilmAffinity::UserRating',
    license             => 'perl',
    dist_author         => q{William Belle <william.belle@gmail.com>},
    dist_version_from   => 'lib/FilmAffinity/UserRating.pm',
    build_requires => {
        'Test::More'       => 0,
        'File::Find::Rule' => 0,
        'Test::MockObject' => 0,
    },
    requires => {
        'perl'                     => 5.006,
        'Text::Trim'               => 0,
        'LWP::RobotUA'             => 0,
        'HTML::TreeBuilder'        => 0,
        'HTML::TreeBuilder::XPath' => 0,
        'Moose'                    => 0,
        'MooseX::Privacy'          => 0,
        'IO::All'                  => 0,
        'Encode'                   => 0,
    },
    add_to_cleanup      => [ 'FilmAffinity-UserRating-*' ],
    create_makefile_pl => 'traditional',
);

$builder->create_build_script();
