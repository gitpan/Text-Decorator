package Text::Decorator::Node;
use 5.006;
use strict;
use warnings;
use Carp;
our $VERSION = '1.0';

=head1 NAME

Text::Decorator::Node - A blob of text in a Text::Decorator decoration

=head1 SYNOPSIS

	$self->new($text);
	$self->format_as("html");

=head1 DESCRIPTION

This represents a piece of text which is going to undergo formatting
and decoration.

=head1 METHODS

=head2 new

    $self->new

Creates a new Text::Decorator::Node instance.

=cut

sub new {
    my ($class, $text) = @_;
    my $self = bless {
        representations => { text => $text},
        notes => {} # So filters can pass messages to each other
    }, $class;
    return $self;
}

=head2 format_as

    $self->format_as($representation)

Returns this node in the specified representation, or plain text.

=cut

sub format_as {
    my ($self, $format) = @_;
    return $self->{representations}{$format} ||
           $self->{representations}{text};
}

1;

=head1 LICENSE

This module is free software, and may be distributed under the same
terms as Perl itself.


=head1 AUTHOR

Copyright (C) 2003, Simon Cozens C<simon@kasei.com>

