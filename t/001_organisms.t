use Test::More;

use Bio::GMOD::RPC::Test::DummyService;
use Bio::GMOD::RPC::Provider::InterMine::Organisms::v1_1;

my $config = {intermine => {server => "www.flymine.org/query"}};

my $provider = Bio::GMOD::RPC::Provider::InterMine::Organisms::v1_1->new(
    service => Bio::GMOD::RPC::Test::DummyService->new($config)
);

note explain($provider->get_data);
