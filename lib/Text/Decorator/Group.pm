package Text::Decorator::Group;
use 5.006;
use strict;
use warnings;
use Carp;
our $VERSION = '1.0';

=head1 NAME

Text::Decorator::Group - A (possibly nested) group of nodes

=head1 SYNOPSIS

	$self->new(...);
	$self->format_as(...);
    $self->nodes

=head1 DESCRIPTION

A Group is a set of nodes that live together for some semantic reason -
paragraphs in a document, sentences in a paragraph, or whatever.

=head1 METHODS

=head2 new

    $self->new

Creates a new Text::Decorator::Group instance.

=cut


sub new {
    my $class = shift;
    my $self = bless {
        nodes => [ @_ ],
        representations => {},
        notes => {}, # What's this group all about, then?

    }, $class;
    return $self;
}

=head2 nodes

    @nodes = $self->nodes;

Returns the nodes which make up this group.

=cut

sub nodes { my $self = shift; return @{$self->{nodes}} }

=head2 format_as

    $self->format_as("html")

Descend into the group, formatting each node, stringing the pieces
together and returning the result, optionally adding some pre- and post-
representation-specific material.

=cut

sub format_as {
    my ($self, $format) = @_;
    my $gformat = $format;
    $gformat = "text" if not exists $self->{representations}{$format};
    no warnings;
    return $self->{representations}{$gformat}{pre}.
        join( $self->{representations}{$gformat}{inter},
            map { $_->format_as($format) }
            $self->nodes
        ).
        $self->{representations}{$gformat}{post};
}

1;

=head1 LICENSE

This module is free software, and may be distributed under the same
terms as Perl itself.


=head1 AUTHOR

Copyright (C) 2003, Simon Cozens C<simon@kasei.com>

