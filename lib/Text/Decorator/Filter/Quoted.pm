package Text::Decorator::Filter::Quoted;
use strict;
use Text::Decorator::Group;
use base 'Text::Decorator::Filter';
use Text::Quoted;

=head1 NAME

Text::Decorator::Filter::Quoted - Mark up paragraphs of quoted text

=head1 DESCRIPTION

This filter uses the L<Text::Quoted> module to add quoting-level style
tags on a HTML representation of piece of text. 

=cut

sub filter_node {
    my ($class, $args, $node) = @_;

    # There's a slight bug here; this filter will obliterate all HTML
    # markup made so far, which is something this module was designed to
    # avoid! It should be that much of a deal, since most markup should
    # be in the group pre- and post- stuff, but this really needs
    # redesigned to preserve properties of existing nodes.
    my $structure = extract($node->format_as("text"));
    my @output;

    # Let's have a level one group
    my $group = $class->_new_group(1);

    $group->{nodes} = [ $class->_traverse($structure, 1) ]; 
    return $group, Text::Decorator::Node->new("\n") # Swallowed somewhere
}


sub _traverse {
    my ($class, $stuff, $level) = @_;
    my @output;
    for (@$stuff) {
        if (ref $_ eq "ARRAY") { 
            # New group
            my $group = $class->_new_group($level + 1);
            $group->{nodes} = [ $class->_traverse($_, $level + 1) ];
            push @output, $group;
        }
        elsif (ref $_ eq "HASH") {
            push @output, Text::Decorator::Node->new($_->{raw}."\n");
        }
    }
    return @output
};

sub _new_group {
    my ($class, $level) = @_;
    my $group = Text::Decorator::Group->new();
    $group->{notes}->{level} = $level;
    $group->{representations}{html}{pre} = "<span class=\"quoted$level\">";
    $group->{representations}{html}{post} = "</span>";
    return $group;
}

1;
