package Bio::GMOD::RPC::InterMine::Role::Configured;

use Moose::Role;

has config => (
    isa => 'HashRef',
    is => 'ro',
    required => 1,
);

1;
