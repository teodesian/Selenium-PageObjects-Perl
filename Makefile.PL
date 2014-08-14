use 5.010;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME              => "Selenium::PageObject",
    VERSION_FROM      => "lib/Selenium/PageObject.pm",
    MIN_PERL_VERSION  => '5.010',
    #Not really sure which versions, but I will make them install via CPAN this way
    TEST_REQUIRES     => {
        "Test::More"               => 0,
        "Test::Fatal"              => 0,
        "Test::Deep"               => 0,
        "Selenium::Remote::Driver" => 0,
        "WWW::Selenium"            => 0,
        "File::Basename"           => 0,
        "Cwd"                      => 0
    },
    PREREQ_PM => {
        "Carp"                     => 0,
        "Scalar::Util"             => 0,
        "Try::Tiny"                => 0,
        "Selenium::Remote::Driver" => 0 #Used for WDKeys
    }
);
