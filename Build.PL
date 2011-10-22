use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Bio::GMOD::RPC::Formatter',
    license             => 'perl',
    dist_author         => q{Alex Kalderimis <alex@intermine.org>},
    dist_version_from   => 'lib/Bio/GMOD/RPC/Formatter.pm',
    build_requires => {
        'Test::More' => 0,
    },
    add_to_cleanup      => [ 'Bio-GMOD-RPC-InterMine-*' ],
    create_makefile_pl => 'traditional',
);

$builder->create_build_script();
