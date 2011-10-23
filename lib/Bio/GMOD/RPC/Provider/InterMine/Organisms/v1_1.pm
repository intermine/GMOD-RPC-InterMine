package Bio::GMOD::RPC::Provider::InterMine::Organisms::v1_1;

use strict;
use warnings;

use Moose;
use Webservice::InterMine;
use List::MoreUtils qw/zip/;

with 'Bio::GMOD::RPC::Provider';

sub get_data {
    my $self = shift;

    my $im = get_service($self->service->config->{intermine}{server});

    [map { {zip @{[qw/genus species taxonomy_id/]}, @$_} }
        $im->table("Organism")->select(qw/genus species taxonId/)->all()]
}

1;
