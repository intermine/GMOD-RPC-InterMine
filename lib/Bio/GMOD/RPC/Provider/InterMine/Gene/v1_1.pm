package Bio::GMOD::RPC::Provider::InterMine::Gene::v1_1;

use strict;
use warnings;

use Moose;
use Webservice::InterMine 0.9811;

with 'Bio::GMOD::RPC::Provider';
with 'Bio::GMOD::RPC::InterMine::SOResolver';

# Params:
# REQUIRED:
#  term
# OPTIONAL:
#  type (default: Gene)
#  taxon
#  species
#  genus
sub get_data {
    my $self = shift;
    my %params = @_;
    $params{type} ||= "Gene";
    if ($params{type} =~ /^SO:/) {
        $params{type} = ucfirst($self->_resolve_SO_id($params{type}, "SO"));
    }

    my $im = get_service($self->service->config->{intermine}{server});

    my $rs = $im->resultset($params{type})->where($params{type} => {lookup => $params{term}});
    
    if ( $params{taxon} ) {
        $rs = $rs->where("$params{type}.organism.taxonId" => $params{taxon});
    } else {
        $rs = $rs->where("$params{type}.organism.genus" => $params{genus}) if $params{genus};
        $rs = $rs->where("$params{type}.organism.species" => $params{species}) if $params{species};
    }

    [ map {$_->{accession} = $_->{primaryIdentifier}; $_} map { $_->to_href("short") } $rs->all()];
}

1;

