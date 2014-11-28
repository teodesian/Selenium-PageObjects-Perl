use strict;
use warnings;

use Test::Pod 'tests' => 4;
use Test::Pod::Coverage;
use Selenium::PageObject;
use Selenium::Element;

my @pobjfiles = map { $INC{$_} } ('Selenium/PageObject.pm','Selenium/Element.pm');
foreach my $pm (@pobjfiles) {
    pod_file_ok($pm);
}

my @modules = ('Selenium::PageObject', 'Selenium::Element');
foreach my $mod (@modules) {
    pod_coverage_ok($mod);
}
