package Text::Decorator::Filter::Test;

use base 'Text::Decorator::Filter';

sub filter_text {
	s/\S/x/g;
}

1;
