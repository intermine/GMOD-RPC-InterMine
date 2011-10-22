package Bio::GMOD::RPC::Provider::InterMine::Organisms::v1_1;

use Moose;

with 'Bio::GMOD::RPC::InterMine::Role::Configured';

sub get_data {
    my $self = shift;
    my $params = shift;
}

1;
