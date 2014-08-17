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
    },
    META_MERGE => {
        'meta-spec' => { version => 2 },
        name        => 'Selenium::PageObject',
        abstract    => "Perl implementation of selenium PageObjects",
        author      => ['George S. Baugh <teodesian@cpan.org>'],
        resources   => {
             repository => {
                 type => 'git',
                 url  => 'https://github.com/teodesian/Selenium-PageObjects-Perl.git',
                 web  => 'https://github.com/teodesian/Selenium-PageObjects-Perl',
             },
        },
        license => ['artistic_2'],
        prereqs => {
            runtime => {
                requires => {
                    'perl'                     => '5.010',
                    "Carp"                     => 0,
                    "Scalar::Util"             => 0,
                    "Try::Tiny"                => 0,
                    "Selenium::Remote::Driver" => 0 #Used for WDKeys
                }
            },
            test => {
                requires => {
                    "Test::More"               => 0,
                    "Test::Fatal"              => 0,
                    "Test::Deep"               => 0,
                    "Selenium::Remote::Driver" => 0,
                    "WWW::Selenium"            => 0,
                    "File::Basename"           => 0,
                    "Cwd"                      => 0
                },
            }
        },
        provides => {
            'Selenium::PageObject' => {
                file    => 'lib/Selenium/PageObject.pm',
                version => '0.007'
            },
            'Selenium::Element' => {
                file    => 'lib/Selenium/Element.pm',
                version => '0.006'
            }
        }
    }
);
