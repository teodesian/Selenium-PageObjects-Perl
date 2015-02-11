Selenium-PageObjects-Perl
=========================

<img src="https://travis-ci.org/teodesian/Selenium-PageObjects-Perl.svg" alt="Travis CI build status" />
<a href='https://coveralls.io/r/teodesian/Selenium-PageObjects-Perl'><img src='https://coveralls.io/repos/teodesian/Selenium-PageObjects-Perl/badge.svg' alt='Coverage Status' /></a>

Perl module/class to help create Page Objects.  Analogous to Selenium's PageFactory Class.
Can use both WWW::Selenium and Selenium::Remote::Driver objects as drivers.

See:
https://code.google.com/p/selenium/wiki/PageFactory for info about PageFactory
and
https://code.google.com/p/selenium/wiki/PageObjects
for more info about page objects themselves.

Example Usage:

> package SomePage;
>
> use Selenium::PageObject;
>
> our @ISA = qw(SeleniumPageObject);
>
>
> sub new {
>
>    my ($class,$driver);
>
>    return $class->SUPER::new($class,$driver,"/somepage.html");
>
> }
>
>
> sub doStuff {
>
>   my ($self,$stuff2type,$option2select);
>
>   my $textBox = $self->SUPER::getElement('someBox','id');
>
>   my $customResult = $textBox->set($stuff2type,sub {
>
>       my $self = shift; #full access to parent page object
>
>       $self->dismissAlert(); #Callback to dismiss stupid alert that pops up when we type stuff into this box...
>
>       return $self->driver->doSomethingSpecificToMyDriverModule('foo'); #While the underlying driver is always available, you should avoid doing this in pageObjects you expect to work with any driver module.
>
>   });
>
>
>   my $successes = 0;
>
>   my $count = scalar(@listboxes);
>
>   my @listBoxes = $self->SUPER::getElement('.listbox','class');
>
>   foreach my $box (@listboxes) {
>
>        #Set all boxes to have the relevant element selected.
>
>        unless ($box->isSelect) {
>
>            $count--;
>
>            next;
>
>        }
>
>        warn "box has no glarch option" unless $box->hasOptions($options2select));
>
>        $successes += $box->set($option2select); #returns 1 or 0 depending on whether it could set it or not
>
>    }
>
>    return !($count - $success); # if successes = num of listboxes, yay
>
> }
>
>
> sub Submit {
>
>   my $self = shift;
>
>   return $self->SUPER::submit('someButton','id',sub {...}); #Callback to handle whatever we think a successful submission does
>
> }

How the test author should end up using this:

> use Selenium::Remote::Driver;
>
> use SomePage; #The module we made above
>
> my $webDriver = Selenium::Remote::Driver->new({'remote_server_addr' => 'localhost');
>
> $webDriver->get('http://my-app.test/');
>
> my $somePage = SomePage->new($webDriver);
>
> $somePage->doStuff('blah','someOption');
>
> ok($somePage->Submit(),"Page did needful");

Refer to the POD for futher information.
