=head1 NAME
Configure - Class with some util configurations of Perl Tk Development

=head1 DESCRIPTION
This class can 
=cut
package Configure;

use base 'Exporter';

our @EXPORT = qw ($resource_location $internationalization $image_location $new_img $open_img 
$save_img $undo_img $redo_img $cut_img $copy_img $paste_img $run_img $source_img 
$icon_location);

#######################################################
# Applications Internationalization Resources
#######################################################
our $resource_location   = './share/locate/';
our $internationalization = 'ptbr';

#######################################################
# Applications Image Locations
#######################################################
our $image_location   = './share/pixmap/default/';

our $new_img = $image_location . 'document-new.png';
our $open_img = $image_location . 'document-open.png';
our $save_img = $image_location . 'document-save.png';

our $undo_img = $image_location . 'edit-undo.png';
our $redo_img = $image_location . 'edit-redo.png';

our $cut_img = $image_location . 'edit-cut.png';
our $copy_img = $image_location . 'edit-copy.png';
our $paste_img = $image_location . 'edit-paste.png';

our $run_img = $image_location . 'media-playback-start.png';
our $source_img = $image_location . 'gtk-edit.png';

#######################################################
# Applications Icons Locations
#######################################################
our $icon_location   = './share/pixmap/actions';

=head1 Author
Daniel Vinciguerra <daniel-vinciguerra@hotmail.com>

=cut
1;