package Text::Decorator::Filter::URIFind;
use Carp;
use strict;
use Text::Decorator::Group;
use base 'Text::Decorator::Filter';

=head1 NAME

Text::Decorator::Filter::URIFind - Turn URLs into links

=head1 DESCRIPTION

This filter uses the L<URI::Find> module to mark up URLs as links. 
You can also pass a classname as an argument to this filter, if you
prefer using C<URI::Find::Schemeless> or whatever.

=cut

sub filter_node {
    my ($class, $args, $node) = @_;

    my $urifind = shift(@$args) || "URI::Find";
    $urifind->require or croak "Couldn't load $urifind";

    my $finder = $urifind->new(sub{
         my ($uri, $orig_uri) = @_;
         return qq#<a href="$uri">$orig_uri</a>#;
                 });
    my $orig = $node->format_as("html");
    $finder->find(\$orig);
    $node->{representations}{html} = $orig;
    return $node;
}

1;
