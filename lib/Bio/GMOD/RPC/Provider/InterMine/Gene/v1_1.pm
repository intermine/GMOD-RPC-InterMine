package Bio::GMOD::RPC::Provider::Gene::v1_1;

use strict;
use warnings;

use Moose;

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
    my $params{type} ||= "Gene";
    if ($params{type} =~ /^SO:/) {
        $params{type} = ucfirst($self->_resolve_SO_id($type, "SO"));
    }

    my $im = get_service($self->service->config->{intermine}{server});

    my $rs = $im->resultset($params{type})->where($params{type} => {lookup => $params{term}});
    
    if ( $params{taxon} ) {
        $rs = $rs->where("$params{type}.organism.taxonId" => $params{taxon});
    } else {
        $rs = $rs->where("$params{type}.organism.genus" => $params{species});
        $rs = $rs->where("$params{type}.organism.species" => $params{species});
    }

    [ map {$_->{accession} = $_->{primaryIdentifier}; $_} 
        map { my $row = $_->href;
            {map { $_ => $row->{$_} } grep { $_ !~ /^$params{type}/} keys %$row};
        } $rs->all()];
}

1;

