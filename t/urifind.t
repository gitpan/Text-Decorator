# vim:ft=perl
use Test::More qw(no_plan);

use Text::Decorator;

my $decorator = new Text::Decorator ("foo & http://www.perl.com/ bar");
$decorator->add_filter(TTBridge => html => "html");
$decorator->add_filter("URIFind");
is($decorator->format_as("html"), 
    'foo &amp; <a href="http://www.perl.com/">http://www.perl.com/</a> bar',
    "HTML formatting OK");
is($decorator->format_as("text"), "foo & http://www.perl.com/ bar", "Text formatting OK");
