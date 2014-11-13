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
		'Test::More'            => 0,
		'Test::JSON'            => 0.11,
		'File::Find::Rule'      => 0.33,
		'Test::MockObject'      => 1.20,
		'Test::LongString'      => 0.15,
	},
	requires => {
		'perl'                     => 5.006,
		'Text::Trim'               => 1.02,
		'LWP::RobotUA'             => 6.03,
		'HTML::TreeBuilder'        => 5.03,
		'HTML::TreeBuilder::XPath' => 0.14,
		'Moose'                    => 2.12,
		'MooseX::Privacy'          => 0.05,
		'IO::All'                  => 0.67,
		'Encode'                   => 2.57,
		'JSON'                     => 2.90,
		'List::Compare'            => 0.39,
		'Readonly'                 => 2.00,
		'File::Copy::Recursive'    => 0.38,
	},
	add_to_cleanup     => ['FilmAffinity-UserRating-*'],
	create_makefile_pl => 'traditional',
);

$builder->create_build_script();
