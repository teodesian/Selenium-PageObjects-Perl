use Test::More;
use Test::Fatal;

use Selenium::Remote::Driver;
#use WWW::Selenium;
use Selenium::Server;
use Selenium::PageObject;

use File::Basename;
use Cwd qw(abs_path);

like( exception {Selenium::PageObject->new()} , qr/Driver must be an instance/ , "Must pass driver");
like( exception {Selenium::PageObject->new('whee')}, qr/Driver must be an instance/, "Must pass W::S or S::R::D object");

my $host = '10.4.15.3';
my $browser_name = 'firefox';
#my $browser_name = 'htmlunit';
#my $host = 'localhost';
#my $selenium_server = Selenium::Server->new();
#$selenium_server->start();

my $webd = Selenium::Remote::Driver->new('remote_server_addr' => $host,'browser_name'=>$browser_name);

my $dir = dirname(abs_path($0));
my $remote_fname = dirname($webd->upload_file( "$dir/test.html" ));

my $pod = Selenium::PageObject->new($webd,"file://$remote_fname$dir/test.html");
isa_ok($pod,"Selenium::PageObject");

#Get the form element
$element = $pod->getElement('testForm','id');
isa_ok($element,"Selenium::Element");
is($element->get_tag_name,"form","Can get tag name using WebDriver");
ok($element->is_form,"Can get if element is form using WebDriver");
ok(!$element->get_type(),"Cannot get type of non-input");
ok(!$element->is_textinput,"Element correctly reported as not textinput");
ok(!$element->is_fileinput,"Element correctly reported as not fileinput");
ok(!$element->is_radio,"Element correctly reported as not radio");
ok(!$element->is_select,"Element correctly reported as not select");
ok(!$element->is_option,"Element correctly reported as not option");
ok(!$element->is_checkbox,"Element correctly reported as not cb");
ok(!$element->has_option('someOption'),"Cannot get options for non-select");

my $value;

#Get all the inputs for the form
@inputs = $pod->getElements('#testForm input, #testForm textarea, #testForm select, #testForm select option','css');
foreach my $input (@inputs) {
    subtest 'Element state is as expected' => sub {
        isa_ok($input,"Selenium::Element");
        ok($input->get_tag_name,"Can get tag name using WebDriver");
        ok(!$input->is_form,"Can get if element is not form using WebDriver");
        ok(!$input->get_type(),"Cannot get type of non-input") if !$input->is_input;
        ok($input->get_type(),"Can get type of input") if $input->is_input;
        ok($input->is_textinput,"Element correctly reported as not textinput") if $input->id eq 'textinput1';
        ok($input->is_fileinput,"Element correctly reported as not fileinput") if $input->id eq 'file1';
        ok($input->is_radio,"Element correctly reported as not radio") if grep {$_ eq $input->id} qw('radio1 radio2');
        ok($input->is_select,"Element correctly reported as not select") if $input->id eq 'select1';
        ok($input->is_option,"Element correctly reported as not option") if grep {$_ eq $input->name} qw('option1 option2 option3');
        ok($input->is_checkbox,"Element correctly reported as not cb") if $input->id eq 'cb4';
        ok(!$input->has_option('someOption'),"Cannot get options for non-select") if $input->get_tag_name ne 'select';
        ok($input->has_option('option2'),"Can get options for select") if $input->get_tag_name eq 'select';
        #Test getters/setters
        $value = $input->get();
        diag explain $value;
    };
}


ok($element->submit(),"Can submit a form");

#TODO WWW::Selenium Tests.
#my $sel  = WWW::Selenium->new('host' => 'localhost');
#my $powd = Selenium::PageObject->new($sel,"file://$dir/test.html");

$webd->quit();
#$server->stop();

done_testing();
