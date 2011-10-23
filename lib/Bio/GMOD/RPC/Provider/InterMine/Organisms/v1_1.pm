package Bio::GMOD::RPC::Provider::InterMine::Organisms::v1_1;

use strict;
use warnings;

use Moose;
use Webservice::InterMine;

with 'Bio::GMOD::RPC::Provider';

sub get_data {
    my $self = shift;
    my %params = @_;

    my $im = get_service($self->service->config->{intermine}{server});

    my $query = $im->new_query(class => "Organism")->select(qw/genus species taxonId/);

    [map { {genus => $_->[0], species => $_->[1], taxonomy_id => $_->[2] } } $query->all];
}

1;
