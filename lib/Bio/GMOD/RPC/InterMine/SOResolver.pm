package Bio::GMOD::RPC::InterMine::SOResolver;

use Moose::Role;

use SOAP::Lite;

has _ebi => (
    default => sub { SOAP::Lite->service("http://www.ebi.ac.uk/ontology-lookup/OntologyQuery.wsdl") },
    handles => {_resolve_SO_id => "getTermById"},
);

1;
