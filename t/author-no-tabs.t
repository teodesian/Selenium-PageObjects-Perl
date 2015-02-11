
BEGIN {
    unless ( $ENV{AUTHOR_TESTING} ) {
        require Test::More;
        Test::More::plan(
            skip_all => 'these tests are for testing by the author' );
    }
}

use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::Test::NoTabs 0.09

use Test::More 0.88;
use Test::NoTabs;

my @files = (
    'lib/Selenium/Element.pm',     'lib/Selenium/PageObject.pm',
    't/00-compile.t',              't/Selenium-PageObject.t',
    't/author-critic.t',           't/author-eol.t',
    't/author-no-tabs.t',          't/author-pod-spell.t',
    't/release-cpan-changes.t',    't/release-kwalitee.t',
    't/release-minimum-version.t', 't/release-mojibake.t',
    't/release-pod-linkcheck.t',   't/release-pod-syntax.t',
    't/release-synopsis.t',        't/release-test-version.t',
    't/release-unused-vars.t',     't/test.html'
);

notabs_ok($_) foreach @files;
done_testing;
