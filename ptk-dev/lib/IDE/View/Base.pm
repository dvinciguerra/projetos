=head1 NAME
IDE::View::Main - Main Window of Perl Tk Development IDE

=head1 DESCRIPTION
This class can provide access to build the ide main interface.
=cut
package IDE::View::Main;

use strict;
use base 'Tk';

sub new {
	my $class = shift;
	my $self = $class->SUPER::new(-title=>shift);
	return bless $self, $class;
}

sub draw {
	my $self = shift;
	
	MainLoop;
}

#######################################################
# Applications Icons Locations
#######################################################
our $icon_location   = './share/pixmap/actions';

=head1 Author
Daniel Vinciguerra <daniel-vinciguerra@hotmail.com>

=cut
1;