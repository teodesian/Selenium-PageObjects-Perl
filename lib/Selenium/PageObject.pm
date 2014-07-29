package Selenium::PageObject;
{
    $Selenium::PageObject::VERSION = '0.001';
}

use Carp;
use Scalar::Util qw(reftype blessed);
use Try::Tiny;
use Selenium::Element;

sub new {
    my ($class,$driver,$uri) = @_;
    confess("Constructor must be called statically, not by an instance") if ref($class);
    confess("Driver must be an instance of Selenium::Remote::Driver or WWW::Selenium") if !( grep {defined(blessed($driver)) && $_ eq blessed($driver)} qw(Selenium::Remote::Driver WWW::Selenium) );

    my $self = {
        'drivertype' => blessed($driver) eq 'WWW::Selenium',
        'driver'     => $driver,
        'page'       => $uri
    };

    $self->{'drivertype'} ?  $driver->open($url) : $driver->get($uri); #Get initial page based on what type of driver used

    bless $self, $class;
    return $self;
}

sub getElement {
    my ($self,$selector,$selectortype) = @_;
    my $element;
    if ($self->{'drivertype'}) {
        $element = $self->{'driver'}->is_element_present("$selectortype=$selector") ? "$selectortype=$selector" : undef;
    } else {
        try {
            $element = $self->{'driver'}->find_element($selector,$selectortype);
        } catch {
            print "# $_ \n";
            $element = undef;
        }
    }
    return Selenium::Element->new($element,$self->{'drivertype'} ? $self->{'driver'} : $self->{'drivertype'});
}

sub getElements {
    my ($self,$selector,$selectortype) = @_;
    my $elements = [];
    confess ("WWW::Selenium is designed to work with single elements.  Consider refining your selectors and looping instead.") if $self->{'drivertype'};
    try {
        @elements = $self->{'driver'}->find_elements($selector,$selectortype);
    };
    return map {Selenium::Element->new($_,$self->{'drivertype'} ? $self->{'driver'} : $self->{'drivertype'})} @elements;
}

1;
