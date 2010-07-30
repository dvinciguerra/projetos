#!C:\Perl\bin\perl.exe -w

use strict;

use Tk;
use Tk::Button;
use Tk::Balloon;
use Tk::Frame;
use Tk::Label;
use Tk::Menu;
use Tk::Menubutton;
use Tk::Text;
use Tk::PNG;

my $line = 1;

my $mw =  MainWindow->new( 
	-title => 'Perl Tk Development - Source Code Editor' 
);
my $tooltip = $mw->Balloon(
    -background => "lightyellow",
    -initwait   => 550
);

###############################################
## Application Menu
###############################################
my $Menu = $mw -> Frame (
    -borderwidth=>1,
    -relief=>'raised'
) -> pack(
    -fill=>'x'
);

# File menu
my $File = $Menu -> Menubutton (
    -state=>'normal',
    -justify=>'left',
    -relief=>'flat',
    -compound=>'none',
    -text=>'Arquivo',
    -underline=>0
) -> pack(
    -side=>'left'
);
my $wm_file = $File -> Menu (
    -tearoff=>0,
    -relief=>'raised'
);
$File->configure(
    -menu=>$wm_file
);
$mw -> Photo (
    'img_mnew',
    -file => './share/pixmap/menu/document-new.png',
    '-format' => 'PNG'
);
my $cmd_new = $wm_file -> command (
    '-image' => 'img_mnew',
    -label=>'   Novo Arquivo',
    -compound=>'left'
);
$mw -> Photo (
    'img_mopen',
    -file => './share/pixmap/menu/document-open.png',
    '-format' => 'PNG'
);
my $cmd_open = $wm_file -> command (
    '-image' => 'img_mopen',
    -label=>'   Abrir Arquivo',
    -compound=>'left',
	-command => \&open_file,
);
$mw -> Photo (
    'img_msave',
    -file => './share/pixmap/menu/document-save.png',
    '-format' => 'PNG'
);
my $cmd_save = $wm_file -> command (
    '-image' => 'img_msave',
    -label=>'   Salvar Arquivo',
    -compound=>'left',
	-command => \&save_file
);
my $cmd_recents = $wm_file -> cascade (
    -label=>'         Recente'
);
my $wm_recent = $wm_file -> Menu (
    -tearoff=>0,
    -relief=>'raised'
);
$cmd_recents->configure(
    -menu=>$wm_recent
);
my $cmd_recent01 = $cmd_recents -> command (
    -label=>'Undefined'
);
my $cmd_recent02 = $cmd_recents -> command (
    -label=>'Undefined'
);
my $cmd_recent03 = $cmd_recents -> command (
    -label=>'Undefined'
);
$wm_file -> separator ();
my $cmd_close = $wm_file -> command (
    -label=>'         Fechar'
);
$mw -> Photo (
    'img_mexit',
    -file => './share/pixmap/menu/application-exit.png',
    '-format' => 'PNG'
);
my $cmd_exit = $wm_file -> command (
    '-image' => 'img_mexit',
    -label=>'   Sair                        Ctrl+Q',
    -command=>sub{exit();},
    -compound=>'left'
);

# Edit menu
my $Edit = $Menu -> Menubutton (
    -state=>'normal',
    -justify=>'left',
    -relief=>'flat',
    -compound=>'none',
    -text=>'Editar'
) -> pack(
    -side=>'left'
);
my $wm_edit = $Edit -> Menu (
    -tearoff=>0,
    -relief=>'raised'
);
$Edit->configure(
    -menu=>$wm_edit
);
$mw -> Photo (
    'img_mundo',
    -file => './share/pixmap/menu/edit-undo.png',
    '-format' => 'PNG'
);
my $cmd_undo = $wm_edit -> command (
    '-image' => 'img_mundo',
    -label=>'   Undo                        Ctrl+Z',
    -compound=>'left'
);
$mw -> Photo (
    'img_mredo',
    -file => './share/pixmap/menu/edit-redo.png',
    '-format' => 'PNG'
);
my $cmd_redo = $wm_edit -> command (
    '-image' => 'img_mredo',
    -label=>'   Redo                        Ctrl+Y',
    -compound=>'left'
);
$wm_edit -> separator ();
$mw -> Photo (
    'img_mcut',
    -file => './share/pixmap/menu/edit-cut.png',
    '-format' => 'PNG'
);
my $cmd_cut = $wm_edit -> command (
    '-image' => 'img_mcut',
    -label=>'   Recortar                   Ctrl+X',
    -compound=>'left'
);
$mw -> Photo (
    'img_mcopy',
    -file => './share/pixmap/menu/edit-copy.png',
    '-format' => 'PNG'
);
my $cmd_copy = $wm_edit -> command (
    '-image' => 'img_mcopy',
    -label=>'   Copiar                      Ctrl+C',
    -compound=>'left'
);
$mw -> Photo (
    'img_mpaste',
    -file => './share/pixmap/menu/edit-paste.png',
    '-format' => 'PNG'
);
my $cmd_paste = $wm_edit -> command (
    '-image' => 'img_mpaste',
    -label=>'   Colar                        Ctrl+V',
    -compound=>'left'
);
$wm_edit -> separator ( );
my $cmd_convert = $wm_edit -> command (
    -label=>'         Converter para...    Ctrl+T',
    -compound=>'left'
);
$mw -> Photo (
    'img_meditcode',
    -file => './share/pixmap/menu/gtk-edit.png',
    '-format' => 'PNG'
);
my $cmd_source = $wm_edit -> command (
    '-image' => 'img_meditcode',
    -label=>'   Editar codigo            Ctrl+E',
    -compound=>'left'
);
$wm_edit -> separator ( );
$mw -> Photo (
    'img_mproperties',
    -file => './share/pixmap/menu/stock_properties.png',
    '-format' => 'PNG'
);
my $cmd_preferences = $wm_edit -> command (
    '-image' => 'img_mproperties',
    -label=>'   Preferências           ',
    -compound=>'left'
);


# Project menu
my $Project = $Menu -> Menubutton (
    -state=>'normal',
    -justify=>'left',
    -relief=>'flat',
    -compound=>'none',
    -text=>'Projeto'
) -> pack(
    -side=>'left'
);
my $wm_project = $Project -> Menu (
    -tearoff=>0
);
$Project->configure(
    -menu=>$wm_project
);
my $cmd_proj_prop = $wm_project -> command (
    '-image' => 'img_mproperties',
    -label=>'   Propriedades do Projeto',
    -compound => 'left'
);
$mw -> Photo (
    'img_mhome',
    -file => './share/pixmap/menu/gtk-home.png',
    '-format' => 'PNG'
);

my $cmd_build = $wm_project -> command (
    '-image'=>'img_mproperties',
    -label=>'   Construtir Projeto         Ctrl+F11',
    -compound=>'left'
);
my $cmd_check = $wm_project -> command (
    -label=>'         Checar Sintaxe             Ctrl+F8',
    -compound=>'left'
);
$wm_project -> separator ( );
$mw -> Photo (
    'img_mprun',
    -file => './share/pixmap/menu/gtk-media-play-ltr.png',
    '-format' => 'PNG'
);
my $cmd_runproj = $wm_project -> command (
    '-image' => 'img_mprun',
    -label=>'   Executar Projeto           F11',
    -compound => 'left'
);

# Tools menu
my $Tools = $Menu -> Menubutton (
    -state=>'normal',
    -justify=>'left',
    -relief=>'flat',
    -compound=>'none',
    -text=>'Ferramentas'
) -> pack(
    -side=>'left'
);
my $wm_tools = $Tools -> Menu (
    -tearoff=>0
);
$Tools->configure(
    -menu=>$wm_tools
);
my $cmd_podview = $wm_tools -> command (
    '-image' => '',
    -label=>'         Navegador POD',
    -compound=>'left'
);
my $cmd_regex = $wm_tools -> command (
    '-image' => '',
    -label=>'         Ferramenta de Expressão Regular',
    -compound=>'left'
);

# Help menu
my $Ajuda = $Menu -> Menubutton (
    -text=>'Ajuda',
    -relief=>'flat'
) -> pack(
    -side=>'left'
);
my $wm_ajuda = $Ajuda -> Menu (
    -tearoff=>0
);
$Ajuda->configure(
    -menu=>$wm_ajuda
);
my $cmd_pabout = $wm_ajuda -> command (
    -label=>'   Sobre'
);


################################################
# Application Toolbar
################################################
my $Toolbar =
  $mw->Frame( -borderwidth => 1, -relief => 'raised' )->pack( -fill => 'x' );
$mw->Photo(
    'img_new',
    -file     => './share/pixmap/menu/document-new.png',
    '-format' => 'PNG'
);
my $btn_new = $Toolbar->Button(
    '-image'    => 'img_new',
    -overrelief => 'flat',
    -relief     => 'flat',
    -compound   => 'none',
    -state      => 'normal'
)->pack( -ipadx => 2, -side => 'left' );
$mw->Photo(
    'img_open',
    -file     => './share/pixmap/menu/document-open.png',
    '-format' => 'PNG'
);
my $btn_open = $Toolbar->Button(
    '-image'    => 'img_open',
    -overrelief => 'flat',
    -relief     => 'flat',
    -compound   => 'none',
    -state      => 'normal',
	-command => \&open_file
)->pack( -ipadx => 2, -side => 'left' );
$mw->Photo(
    'img_save',
    -file     => './share/pixmap/menu/document-save.png',
    '-format' => 'PNG'
);
my $btn_save = $Toolbar->Button(
    '-image'    => 'img_save',
    -overrelief => 'flat',
    -relief     => 'flat',
    -compound   => 'none',
    -state      => 'normal',
	-command => \&save_file
)->pack( -ipadx => 2, -side => 'left' );
$mw->Photo(
    'img_saveas',
    -file     => './share/pixmap/menu/document-save-as.png',
    '-format' => 'PNG'
);
my $btn_saveas = $Toolbar->Button(
    '-image'    => 'img_saveas',
    -overrelief => 'flat',
    -relief     => 'flat',
    -compound   => 'none',
    -state      => 'normal'
)->pack( -ipadx => 2, -side => 'left' );
my $lbl_space1 = $Toolbar->Label(
    -justify    => 'left',
    -foreground => 'gray50',
    -text       => '|',
    -relief     => 'flat'
)->pack( -ipadx => 2, -side => 'left' );
$mw->Photo(
    'img_print',
    -file     => './share/pixmap/menu/document-print.png',
    '-format' => 'PNG'
);
my $btn_print = $Toolbar->Button(
    '-image'    => 'img_print',
    -overrelief => 'flat',
    -relief     => 'flat',
    -compound   => 'none',
    -state      => 'normal'
)->pack( -ipadx => 2, -side => 'left' );
my $lbl_space2 = $Toolbar->Label(
    -justify    => 'left',
    -foreground => 'gray50',
    -relief     => 'flat',
    -text       => '|'
)->pack( -ipadx => 2, -side => 'left' );
$mw->Photo(
    'img_cut',
    -file     => './share/pixmap/menu/edit-cut.png',
    '-format' => 'PNG'
);
my $btn_cut = $Toolbar->Button(
    '-image'    => 'img_cut',
    -overrelief => 'flat',
    -relief     => 'flat',
    -compound   => 'none',
    -state      => 'normal'
)->pack( -ipadx => 2, -side => 'left' );
$mw->Photo(
    'img_copy',
    -file     => './share/pixmap/menu/edit-copy.png',
    '-format' => 'PNG'
);
my $btn_copy = $Toolbar->Button(
    '-image'    => 'img_copy',
    -overrelief => 'flat',
    -relief     => 'flat',
    -compound   => 'none',
    -state      => 'normal'
)->pack( -ipadx => 2, -side => 'left' );
$mw->Photo(
    'img_paste',
    -file     => './share/pixmap/menu/edit-paste.png',
    '-format' => 'PNG'
);
my $btn_paste = $Toolbar->Button(
    '-image'    => 'img_paste',
    -overrelief => 'flat',
    -relief     => 'flat',
    -compound   => 'none',
    -state      => 'normal'
)->pack( -ipadx => 2, -side => 'left' );
my $lbl_space3 = $Toolbar->Label(
    -justify    => 'left',
    -foreground => 'gray50',
    -relief     => 'flat',
    -text       => '|'
)->pack( -ipadx => 2, -side => 'left' );
$mw->Photo(
    'img_undo',
    -file     => './share/pixmap/menu/edit-undo.png',
    '-format' => 'PNG'
);
my $btn_undo = $Toolbar->Button(
    '-image'    => 'img_undo',
    -overrelief => 'flat',
    -relief     => 'flat',
    -compound   => 'none',
    -state      => 'normal'
)->pack( -ipadx => 2, -side => 'left' );
$mw->Photo(
    'img_redo',
    -file     => './share/pixmap/menu/edit-redo.png',
    '-format' => 'PNG'
);
my $btn_redo = $Toolbar->Button(
    '-image'    => 'img_redo',
    -overrelief => 'flat',
    -relief     => 'flat',
    -compound   => 'none',
    -state      => 'normal'
)->pack( -ipadx => 2, -side => 'left' );
my $lbl_space4 = $Toolbar->Label(
    -justify    => 'left',
    -foreground => 'gray50',
    -relief     => 'flat',
    -text       => '|'
)->pack( -ipadx => 2, -side => 'left' );
$mw->Photo(
    'img_check',
    -file     => './share/pixmap/menu/gnome-run.png',
    '-format' => 'PNG'
);
my $btn_check = $Toolbar->Button(
    '-image'    => 'img_check',
    -overrelief => 'flat',
    -relief     => 'flat',
    -compound   => 'none',
    -state      => 'normal'
)->pack( -ipadx => 2, -side => 'left' );

################################################
# Application Body
################################################
my $Body =
  $mw->Frame( -background => 'gray70', -relief => 'flat' )
  ->pack( -fill => 'both', -expand => 1 );
my $txt_linecount = $Body->Text(
    -background => 'gray70',
    -relief     => 'flat',
    -wrap       => 'word',
    -width      => 5,
    -state      => 'disabled'
)->pack( -ipadx => 1, -side => 'left', -fill => 'y', -padx => 1 );
my $Text = $Body->Scrolled(
    'Text',
    -background  => 'White',
    -borderwidth => 1,
    -relief      => 'flat',
    -scrollbars  => 'se',
    -wrap        => 'none',
    -state       => 'normal'
)->pack( -fill => 'both', -expand => 1 );

################################################
# Application Statusbar
################################################
my $Status =
  $mw->Frame( -borderwidth => 1, -relief => 'sunken' )->pack( -fill => 'x' );
my $btn_status = $Status->Button(
    -justify => 'left',
    -text    => 'Syntax checker: projeto1.pl syntax OK',
    -relief  => 'flat'
)->pack( -side => 'left' );
my $lbl_txtinfor = $Status->Label(
    -justify => 'left',
    -text    => 'linha 1. coluna 1 [INS] - 0 caracteres selecionados',
    -relief  => 'flat'
)->pack( -anchor => 'e' );
&line_number;
MainLoop;

#######################################################
# Application Callbacks
#######################################################
sub line_number {
    my $current_ln = 1;
    if (@_) { $current_ln = shift; }

    if ( $current_ln == 1 ) {
        $txt_linecount->Insert('1   ');
    }
    else {
        for ( 1 .. $current_ln ) {
            $txt_linecount->Insert('$_\n');
        }
    }
}


sub open_file {
	$mw->getOpenFile();
}

sub save_file {
	$mw->getSaveFile();
}