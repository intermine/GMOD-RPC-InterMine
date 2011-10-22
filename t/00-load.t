#!perl -T

use Test::More tests => 2;

BEGIN {
    use_ok( 'Bio::GMOD::RPC::Formatter' ) || print "Bail out!
";
    use_ok( 'Bio::GMOD::RPC::Provider' ) || print "Bail out!
";
}

diag( "Testing Bio::GMOD::RPC::Formatter $Bio::GMOD::RPC::Formatter::VERSION, Perl $], $^X" );
