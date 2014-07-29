use Test::More;
use Test::Fatal;

use Selenium::Remote::Driver;
#use WWW::Selenium;
use Selenium::Server;
use Selenium::PageObject;

use Cwd qw(abs_path);

like( exception {Selenium::PageObject->new()} , qr/Driver must be an instance/ , "Must pass driver");
like( exception {Selenium::PageObject->new('whee')}, qr/Driver must be an instance/, "Must pass W::S or S::R::D object");

die;

my $selenium_server = Selenium::Server->new();
$selenium_server->start();

my $webd = Selenium::Remote::Driver->new('remote_server_addr' => 'localhost','browser_name'=>'htmlunit');

my $dir = abs_path($0);

my $pod = Selenium::PageObject->new($webd,"file://$dir/test.html");


#TODO WWW::Selenium Tests.
#my $sel  = WWW::Selenium->new('host' => 'localhost');
#my $powd = Selenium::PageObject->new($sel,"file://$dir/test.html");

$server->stop();

done_testing();
