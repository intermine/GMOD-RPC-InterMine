use Test::More;

use Bio::GMOD::RPC::Test::DummyService;
use Bio::GMOD::RPC::Provider::InterMine::Gene::v1_1;

my $config = {intermine => {server => "www.flymine.org/query"}};

my $provider = Bio::GMOD::RPC::Provider::InterMine::Gene::v1_1->new(
    service => Bio::GMOD::RPC::Test::DummyService->new($config)
);

note explain($provider->get_data(term => "zen"));

note explain($provider->get_data(term => "zen", type => "SO:0000704"));

