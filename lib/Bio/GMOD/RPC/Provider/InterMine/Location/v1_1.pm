package Bio::GMOD::RPC::Provider::InterMine::Location::v1_1;

use strict;
use warnings;

use Moose;
use Webservice::InterMine;

with 'Bio::GMOD::RPC::Provider';
with 'Bio::GMOD::RPC::InterMine::SOResolver';

# Params:
# REQUIRED:
#  chromosome
# OPTIONAL:
#  type (default: SequenceFeature)
#  taxon
#  genus
#  species
#  fmin
#  fmax
#  strand
sub get_data {
    my $self = shift;
    my %params = @_;
    $params{type} ||= "SequenceFeature";
    if ($params{type} =~ /^SO:/) {
        $params{type} = ucfirst($self->_resolve_SO_id($params{type}, "SO"));
    }

    my $im = get_service($self->service->config->{intermine}{server});

    my $rs = $im->resultset($params{type})
                ->select("primaryIdentifier")
                ->where("chromosome.primaryIdentifier" => $params{chromosome});
    
    if ( $params{taxon} ) {
        $rs = $rs->where("$params{type}.organism.taxonId" => $params{taxon});
    } else {
        $rs = $rs->where("$params{type}.organism.genus" => $params{genus}) if $params{genus};
        $rs = $rs->where("$params{type}.organism.species" => $params{species}) if $params{species};
    }
    $rs = $rs->where("chromosomeLocation.start" => {ge => $params{fmin}}) if $params{fmin};
    $rs = $rs->where("chromosomeLocation.end" => {le => $params{fmax}}) if $params{fmax};
    $rs = $rs->where("chromosomeLocation.strand" => $params{strand}) if $params{strand};

    [map { {accession => $_->{primaryIdentifier}} } $rs->all()];
}

1;

