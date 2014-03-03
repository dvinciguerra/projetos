#!/usr/bin/env perl

use lib './lib';
use strict;

use Tk;
use Tk::Adjuster;
use Tk::Button;
use Tk::Balloon;
use Tk::Frame;
use Tk::Tree;
use Tk::LabEntry;
use Tk::Label;
use Tk::Listbox;
use Tk::Menu;
use Tk::Menubutton;
use Tk::NoteBook;
use Tk::Pane;
use Tk::PNG;

use Configure;

## TESTE VARIABLES
my $c_label  = 1;
my $c_button = 1;

###############################################
## Application Main Window
###############################################
my $mw = MainWindow->new( -title => '[No Saved*] - Perl TK Development' );
$mw->minsize(qw(640 480));
my $tooltip = $mw->Balloon(
    -background => "lightyellow",
    -initwait   => 550
);

###############################################
## Application Menu
###############################################
my $Menu = $mw->Frame(
    -borderwidth => 1,
    -relief      => 'raised'
)->pack( -fill => 'x' );

# File menu
my $File = $Menu->Menubutton(
    -state     => 'normal',
    -justify   => 'left',
    -relief    => 'flat',
    -compound  => 'none',
    -text      => 'Arquivo',
    -underline => 0
)->pack( -side => 'left' );
my $wm_file = $File->Menu(
    -tearoff => 0,
    -relief  => 'raised'
);
$File->configure( -menu => $wm_file );
$mw->Photo(
    'img_mnew',
    -file     => './share/pixmap/menu/document-new.png',
    '-format' => 'PNG'
);
my $cmd_new = $wm_file->command(
    '-image'  => 'img_mnew',
    -label    => '   Novo Projeto        Ctrl+N',
    -compound => 'left'
);
$mw->Photo(
    'img_mopen',
    -file     => './share/pixmap/menu/document-open.png',
    '-format' => 'PNG'
);
my $cmd_open = $wm_file->command(
    '-image'  => 'img_mopen',
    -label    => '   Abrir Projeto         Ctrl+O',
    -compound => 'left'
);
$mw->Photo(
    'img_msave',
    -file     => './share/pixmap/menu/document-save.png',
    '-format' => 'PNG'
);
my $cmd_save = $wm_file->command(
    '-image'  => 'img_msave',
    -label    => '   Salvar Projeto       Ctrl+S',
    -compound => 'left'
);
my $cmd_recents = $wm_file->cascade( -label => '         Abrir Recente' );
my $wm_recent = $wm_file->Menu(
    -tearoff => 0,
    -relief  => 'raised'
);
$cmd_recents->configure( -menu => $wm_recent );
my $cmd_recent01 = $cmd_recents->command( -label => 'Undefined' );
my $cmd_recent02 = $cmd_recents->command( -label => 'Undefined' );
my $cmd_recent03 = $cmd_recents->command( -label => 'Undefined' );
$wm_file->separator();
my $cmd_close = $wm_file->command( -label => '         Fechar' );
$mw->Photo(
    'img_mexit',
    -file     => './share/pixmap/menu/application-exit.png',
    '-format' => 'PNG'
);
my $cmd_exit = $wm_file->command(
    '-image'  => 'img_mexit',
    -label    => '   Sair                        Ctrl+Q',
    -command  => sub { exit(); },
    -compound => 'left'
);

# Edit menu
my $Edit = $Menu->Menubutton(
    -state    => 'normal',
    -justify  => 'left',
    -relief   => 'flat',
    -compound => 'none',
    -text     => 'Editar'
)->pack( -side => 'left' );
my $wm_edit = $Edit->Menu(
    -tearoff => 0,
    -relief  => 'raised'
);
$Edit->configure( -menu => $wm_edit );
$mw->Photo(
    'img_mundo',
    -file     => './share/pixmap/menu/edit-undo.png',
    '-format' => 'PNG'
);
my $cmd_undo = $wm_edit->command(
    '-image'  => 'img_mundo',
    -label    => '   Undo                        Ctrl+Z',
    -compound => 'left'
);
$mw->Photo(
    'img_mredo',
    -file     => './share/pixmap/menu/edit-redo.png',
    '-format' => 'PNG'
);
my $cmd_redo = $wm_edit->command(
    '-image'  => 'img_mredo',
    -label    => '   Redo                        Ctrl+Y',
    -compound => 'left'
);
$wm_edit->separator();
$mw->Photo(
    'img_mcut',
    -file     => './share/pixmap/menu/edit-cut.png',
    '-format' => 'PNG'
);
my $cmd_cut = $wm_edit->command(
    '-image'  => 'img_mcut',
    -label    => '   Recortar                   Ctrl+X',
    -compound => 'left'
);
$mw->Photo(
    'img_mcopy',
    -file     => './share/pixmap/menu/edit-copy.png',
    '-format' => 'PNG'
);
my $cmd_copy = $wm_edit->command(
    '-image'  => 'img_mcopy',
    -label    => '   Copiar                      Ctrl+C',
    -compound => 'left'
);
$mw->Photo(
    'img_mpaste',
    -file     => './share/pixmap/menu/edit-paste.png',
    '-format' => 'PNG'
);
my $cmd_paste = $wm_edit->command(
    '-image'  => 'img_mpaste',
    -label    => '   Colar                        Ctrl+V',
    -compound => 'left'
);
$wm_edit->separator();
my $cmd_convert = $wm_edit->command(
    -label    => '         Converter para...    Ctrl+T',
    -compound => 'left'
);
$mw->Photo(
    'img_meditcode',
    -file     => './share/pixmap/menu/gtk-edit.png',
    '-format' => 'PNG'
);
my $cmd_source = $wm_edit->command(
    '-image'  => 'img_meditcode',
    -label    => '   Editar codigo            Ctrl+E',
    -compound => 'left'
);
$wm_edit->separator();
$mw->Photo(
    'img_mproperties',
    -file     => './share/pixmap/menu/stock_properties.png',
    '-format' => 'PNG'
);
my $cmd_preferences = $wm_edit->command(
    '-image'  => 'img_mproperties',
    -label    => '   Preferências           ',
    -compound => 'left'
);

# Insert menu
my $Insert = $Menu->Menubutton(
    -state    => 'normal',
    -justify  => 'left',
    -relief   => 'flat',
    -compound => 'none',
    -text     => 'Inserir'
)->pack( -side => 'left' );
my $wm_insert = $Insert->Menu(
    -tearoff => 0,
    -relief  => 'raised'
);
$Insert->configure( -menu => $wm_insert );
$mw->Photo(
    'img_madd_widget',
    -file     => './share/pixmap/menu/gtk-add.png',
    '-format' => 'PNG'
);
my $cmd_addwidget = $wm_insert->command(
    '-image'  => 'img_madd_widget',
    -label    => '   Inserir Widget            Ctrl+I',
    -compound => 'left'
);
$mw->Photo(
    'img_mrem_widget',
    -file     => './share/pixmap/menu/gtk-remove.png',
    '-format' => 'PNG'
);
my $cmd_remwidget = $wm_insert->command(
    '-image'  => 'img_mrem_widget',
    -label    => '   Remover Widget        Ctrl+R',
    -compound => 'left'
);
$wm_insert->separator();
$mw->Photo(
    'img_mren_widget',
    -file     => './share/pixmap/menu/gtk-find-and-replace.png',
    '-format' => 'PNG'
);
my $cmd_renwidget = $wm_insert->command(
    '-image'  => 'img_mren_widget',
    -label    => '   Renomear Widget           F2',
    -compound => 'left'
);

# Project menu
my $Project = $Menu->Menubutton(
    -state    => 'normal',
    -justify  => 'left',
    -relief   => 'flat',
    -compound => 'none',
    -text     => 'Projeto'
)->pack( -side => 'left' );
my $wm_project = $Project->Menu( -tearoff => 0 );
$Project->configure( -menu => $wm_project );
my $cmd_proj_prop = $wm_project->command(
    '-image'  => 'img_mproperties',
    -label    => '   Propriedades do Projeto',
    -compound => 'left'
);
$mw->Photo(
    'img_mhome',
    -file     => './share/pixmap/menu/gtk-home.png',
    '-format' => 'PNG'
);
my $cmd_proj_home = $wm_project->command(
    '-image'  => 'img_mhome',
    -label    => '   Workspace do Projeto',
    -compound => 'left'
);
$wm_project->separator();
my $cmd_build = $wm_project->command(
    '-image'  => 'img_mproperties',
    -label    => '   Construtir Projeto         Ctrl+F11',
    -compound => 'left'
);
my $cmd_check = $wm_project->command(
    -label    => '         Checar Sintaxe             Ctrl+F8',
    -compound => 'left'
);
$wm_project->separator();
$mw->Photo(
    'img_mprun',
    -file     => './share/pixmap/menu/gtk-media-play-ltr.png',
    '-format' => 'PNG'
);
my $cmd_runproj = $wm_project->command(
    '-image'  => 'img_mprun',
    -label    => '   Executar Projeto           F11',
    -compound => 'left'
);

# Tools menu
my $Tools = $Menu->Menubutton(
    -state    => 'normal',
    -justify  => 'left',
    -relief   => 'flat',
    -compound => 'none',
    -text     => 'Ferramentas'
)->pack( -side => 'left' );
my $wm_tools = $Tools->Menu( -tearoff => 0 );
$Tools->configure( -menu => $wm_tools );
my $cmd_podview = $wm_tools->command(
    '-image'  => '',
    -label    => '         Navegador POD',
    -compound => 'left'
);
my $cmd_regex = $wm_tools->command(
    '-image'  => '',
    -label    => '         Ferramenta de Expressão Regular',
    -compound => 'left'
);
my $cmd_plugins = $wm_tools->command(
    '-image'  => '',
    -label    => '         Gerenciador de Plugins',
    -compound => 'left'
);
$wm_tools->separator();
$mw->Photo(
    'img_madd_tool',
    -file     => './share/pixmap/menu/add.png',
    '-format' => 'PNG'
);
my $cmd_add_tool = $wm_tools->command(
    '-image'  => 'img_madd_tool',
    -label    => '   Adicionar Ferramenta Externa',
    -compound => 'left'
);
$wm_tools->separator();

# Help menu
my $Ajuda = $Menu->Menubutton(
    -text   => 'Ajuda',
    -relief => 'flat'
)->pack( -side => 'left' );
my $wm_ajuda = $Ajuda->Menu( -tearoff => 0 );
$Ajuda->configure( -menu => $wm_ajuda );
my $cmd_phelp =
  $wm_ajuda->command( -label => '   Topicos de Ajuda do Programa      F1' );
$wm_ajuda->separator();
my $cmd_plreferences = $wm_ajuda->command( -label => '   Referencias (Perl)' );
my $cmd_ptkreferences =
  $wm_ajuda->command( -label => '   Referencias (Perl/Tk)' );
$wm_ajuda->separator();
my $cmd_pabout = $wm_ajuda->command( -label => '   Sobre o programa' );

###############################################
## Application Toolbar
###############################################
my $Toolbar = $mw->Frame(
    -borderwidth => 1,
    -relief      => 'raised'
  )->pack(
    -ipady => 2,
    -fill  => 'x'
  );
$mw->Photo( 'img_new', -file => $new_img, '-format' => 'PNG' );
my $btn_new = $Toolbar->Button(
    '-image'    => 'img_new',
    -overrelief => 'flat',
    -state      => 'normal',
    -relief     => 'flat',
    -compound   => 'none'
)->pack( -side => 'left', -padx => 2 );
$tooltip->attach( $btn_new, -balloonmsg => "Cria um novo projeto" );
$mw->Photo( 'img_open', -file => $open_img, '-format' => 'PNG' );
my $btn_open = $Toolbar->Button(
    '-image'    => 'img_open',
    -overrelief => 'flat',
    -state      => 'normal',
    -relief     => 'flat',
    -text       => 44,
    -compound   => 'none'
)->pack( -side => 'left', -padx => 2 );
$tooltip->attach( $btn_open, -balloonmsg => "Abre um projeto" );
$mw->Photo( 'img_save', -file => $save_img, '-format' => 'PNG' );
my $btn_save = $Toolbar->Button(
    '-image'    => 'img_save',
    -overrelief => 'flat',
    -state      => 'normal',
    -relief     => 'flat',
    -compound   => 'none'
)->pack( -side => 'left', -padx => 2 );
$tooltip->attach( $btn_save, -balloonmsg => "Salva o projeto atual" );
my $lbl_space1 = $Toolbar->Label(
    -foreground => 'gray50',
    -justify    => 'left',
    -relief     => 'flat',
    -text       => '|'
)->pack( -side => 'left', -padx => 2 );
$mw->Photo( 'img_undo', -file => $undo_img, '-format' => 'PNG' );
my $btn_undo = $Toolbar->Button(
    '-image'    => 'img_undo',
    -overrelief => 'flat',
    -state      => 'normal',
    -relief     => 'flat',
    -text       => 'OO',
    -compound   => 'none'
)->pack( -side => 'left', -padx => 2 );
$tooltip->attach( $btn_undo, -balloonmsg => "Desfaz a ultima ação" );
$mw->Photo( 'img_redo', -file => $redo_img, '-format' => 'PNG' );
my $btn_redo = $Toolbar->Button(
    '-image'    => 'img_redo',
    -overrelief => 'flat',
    -state      => 'normal',
    -relief     => 'flat',
    -text       => 44,
    -compound   => 'none'
)->pack( -side => 'left', -padx => 2 );
$tooltip->attach( $btn_redo, -balloonmsg => "Refaz a ultima ação" );
my $lbl_space2 = $Toolbar->Label(
    -foreground => 'gray50',
    -justify    => 'left',
    -relief     => 'flat',
    -text       => '|'
)->pack( -side => 'left', -padx => 2 );
$mw->Photo( 'img_cut', -file => $cut_img, '-format' => 'PNG' );
my $btn_cut = $Toolbar->Button(
    '-image'    => 'img_cut',
    -overrelief => 'flat',
    -state      => 'normal',
    -relief     => 'flat',
    -text       => 44,
    -compound   => 'none'
)->pack( -side => 'left', -padx => 2 );
$tooltip->attach( $btn_cut, -balloonmsg => "Recorta um widget" );
$mw->Photo( 'img_copy', -file => $copy_img, '-format' => 'PNG' );
my $btn_copy = $Toolbar->Button(
    '-image'    => 'img_copy',
    -overrelief => 'flat',
    -state      => 'normal',
    -relief     => 'flat',
    -text       => 44,
    -compound   => 'none'
)->pack( -side => 'left', -padx => 2 );
$tooltip->attach( $btn_copy, -balloonmsg => "Copia um widget" );
$mw->Photo( 'img_paste', -file => $paste_img, '-format' => 'PNG' );
my $btn_paste = $Toolbar->Button(
    '-image'    => 'img_paste',
    -overrelief => 'flat',
    -state      => 'normal',
    -relief     => 'flat',
    -text       => 44,
    -compound   => 'none'
)->pack( -side => 'left', -padx => 2 );
$tooltip->attach( $btn_paste, -balloonmsg => "Cola um widget" );
my $lbl_space3 = $Toolbar->Label(
    -foreground => 'gray50',
    -justify    => 'left',
    -relief     => 'flat',
    -text       => '|'
)->pack( -side => 'left', -padx => 2 );
$mw->Photo( 'img_run', -file => $run_img, '-format' => 'PNG' );
my $btn_run = $Toolbar->Button(
    '-image'    => 'img_run',
    -overrelief => 'flat',
    -state      => 'normal',
    -relief     => 'flat',
    -text       => 44,
    -compound   => 'none'
)->pack( -side => 'left', -padx => 2 );
$tooltip->attach( $btn_run, -balloonmsg => "Executa a projeto atual" );
$mw->Photo( 'img_source', -file => $source_img, '-format' => 'PNG' );
my $btn_source = $Toolbar->Button(
    '-image'    => 'img_source',
    -overrelief => 'flat',
    -state      => 'normal',
    -relief     => 'flat',
    -text       => 44,
    -compound   => 'none'
)->pack( -side => 'left', -padx => 2 );
$tooltip->attach( $btn_source,
    -balloonmsg => "Exibe o código fonte do projeto atual" );

###############################################
## Application Widget Container
###############################################
my $Body = $mw->Frame( -relief => 'flat' )->pack(
    -fill   => 'both',
    -expand => 1
);
my $p_Widget = $Body->Frame(
    -width       => 200,
    -borderwidth => 1,
    -relief      => 'sunken'
  )->pack(
    -fill => 'y',
    -side => 'left'

  );

# Panel Hight Level
my $btn_hight_level = $p_Widget->Button(
    -anchor     => 'w',
    -overrelief => 'raised',
    -width      => 30,
    -state      => 'normal',
    -relief     => 'raised',
    -text       => '- Niveis Superiores',
    -compound   => 'none'
)->pack( -fill => 'x' );
$mw->Photo(
    'img_mwindow',
    -file     => './share/pixmap/actions/widget-gtk-window.png',
    '-format' => 'PNG'
);
my $btn_mwindow = $p_Widget->Button(
    '-image'    => 'img_mwindow',
    -anchor     => 'w',
    -overrelief => 'flat',
    -state      => 'normal',
    -relief     => 'flat',
    -text       => 'Tk::MainWindow',
    -compound   => 'left'
)->pack( -fill => 'x' );
$mw->Photo(
    'img_mdialog',
    -file     => './share/pixmap/actions/widget-gtk-dialog.png',
    '-format' => 'PNG'
);
my $btn_mdialog = $p_Widget->Button(
    '-image'    => 'img_mdialog',
    -anchor     => 'w',
    -overrelief => 'flat',
    -state      => 'normal',
    -relief     => 'flat',
    -text       => 'Tk::DialogBox',
    -compound   => 'left'
)->pack( -fill => 'x' );

# Panel Containers
my $btn_container = $p_Widget->Button(
    -anchor     => 'w',
    -overrelief => 'raised',
    -state      => 'normal',
    -relief     => 'raised',
    -text       => '- Containers',
    -compound   => 'none'
)->pack( -fill => 'x' );
$mw->Photo(
    'img_wframe',
    -file     => './share/pixmap/actions/widget-gtk-frame.png',
    '-format' => 'PNG'
);
my $btn_wframe = $p_Widget->Button(
    '-image'    => 'img_wframe',
    -anchor     => 'w',
    -overrelief => 'flat',
    -state      => 'normal',
    -relief     => 'flat',
    -text       => 'Tk::Frame',
    -compound   => 'left'
)->pack( -fill => 'x' );
$mw->Photo(
    'img_wpane',
    -file     => './share/pixmap/actions/widget-gtk-custom.png',
    '-format' => 'PNG'
);
my $btn_wpane = $p_Widget->Button(
    '-image'    => 'img_wpane',
    -anchor     => 'w',
    -overrelief => 'flat',
    -state      => 'normal',
    -relief     => 'flat',
    -text       => 'Tk::Pane',
    -compound   => 'left'
)->pack( -fill => 'x' );
$mw->Photo(
    'img_wnotebook',
    -file     => './share/pixmap/actions/widget-gtk-notebook.png',
    '-format' => 'PNG'
);
my $btn_wnotebook = $p_Widget->Button(
    '-image'    => 'img_wnotebook',
    -anchor     => 'w',
    -overrelief => 'flat',
    -state      => 'normal',
    -relief     => 'flat',
    -text       => 'Tk::Notebook',
    -compound   => 'left'
)->pack( -fill => 'x' );

# Panel Control
my $btn_control = $p_Widget->Button(
    -anchor      => 'w',
    -overrelief  => 'raised',
    -state       => 'normal',
    -borderwidth => 1,
    -relief      => 'raised',
    -text        => '- Controle e Exibição',
    -compound    => 'none'
)->pack( -fill => 'x' );
$mw->Photo(
    'img_wlabel',
    -file     => './share/pixmap/actions/widget-gtk-label.png',
    '-format' => 'PNG'
);
my $btn_wlabel = $p_Widget->Button(
    '-image'    => 'img_wlabel',
    -anchor     => 'w',
    -overrelief => 'flat',
    -state      => 'normal',
    -relief     => 'flat',
    -text       => 'Tk::Label',
    -compound   => 'left',
    -command    => \&label
)->pack( -fill => 'x' );
$mw->Photo(
    'img_wentry',
    -file     => './share/pixmap/actions/widget-gtk-entry.png',
    '-format' => 'PNG'
);
my $btn_wentry = $p_Widget->Button(
    '-image'    => 'img_wentry',
    -anchor     => 'w',
    -overrelief => 'flat',
    -state      => 'normal',
    -relief     => 'flat',
    -text       => 'Tk::Entry',
    -compound   => 'left'
)->pack( -fill => 'x' );
$mw->Photo(
    'img_wbutton',
    -file     => './share/pixmap/actions/widget-gtk-button.png',
    '-format' => 'PNG'
);
my $btn_wbutton = $p_Widget->Button(
    '-image'    => 'img_wbutton',
    -anchor     => 'w',
    -overrelief => 'flat',
    -state      => 'normal',
    -relief     => 'flat',
    -text       => 'Tk::Button',
    -compound   => 'left',
    -command    => \&button
)->pack( -fill => 'x' );
$mw->Photo(
    'img_wcheck',
    -file     => './share/pixmap/actions/widget-gtk-checkbutton.png',
    '-format' => 'PNG'
);
my $btn_wcheck = $p_Widget->Button(
    '-image'    => 'img_wcheck',
    -anchor     => 'w',
    -overrelief => 'flat',
    -state      => 'normal',
    -relief     => 'flat',
    -text       => 'Tk::CheckButton',
    -compound   => 'left'
)->pack( -fill => 'x' );
$mw->Photo(
    'img_wradio',
    -file     => './share/pixmap/actions/widget-gtk-radiobutton.png',
    '-format' => 'PNG'
);
my $btn_wradio = $p_Widget->Button(
    '-image'    => 'img_wradio',
    -anchor     => 'w',
    -overrelief => 'flat',
    -state      => 'normal',
    -relief     => 'flat',
    -text       => 'Tk::RadioButton',
    -compound   => 'left'
)->pack( -fill => 'x' );
$mw->Photo(
    'img_woptionmenu',
    -file     => './share/pixmap/actions/widget-gtk-optionmenu.png',
    '-format' => 'PNG'
);
my $btn_woption = $p_Widget->Button(
    '-image'    => 'img_woptionmenu',
    -anchor     => 'w',
    -overrelief => 'flat',
    -state      => 'normal',
    -relief     => 'flat',
    -text       => 'Tk::OptionMenu',
    -compound   => 'left'
)->pack( -fill => 'x' );

###############################################
## Application Dock WYSIWYG (Workspace)
###############################################
my $p_Workspace = $Body->Frame(
    -background  => 'White',
    -borderwidth => 1,
    -relief      => 'sunken'
  )->pack(
    -ipady  => 2,
    -pady   => 2,
    -fill   => 'both',
    -ipadx  => 2,
    -side   => 'left',
    -expand => 1,
    -padx   => 2
  );

## Main Window Representation
my $Main = $p_Workspace->Frame(
    -width       => 500,
    -height      => 350,
    -borderwidth => 1,
    -relief      => 'solid'
  )->pack(
    -ipady  => 2,
    -anchor => 'nw',
    -pady   => 15,
    -ipadx  => 2,
    -side   => 'left',
    -padx   => 15
  );

my $w_packAdjust_215 = $p_Widget->packAdjust();

###############################################
## Dock Inspector
###############################################
my $p_Properties = $Body->Frame(
    -borderwidth => 1,
    -relief      => 'sunken'
  )->pack(
    -anchor => 'ne',
    -fill   => 'both',
    -side   => 'right'
  );
my $w_packAdjust_090 = $p_Properties->packAdjust();
my $btn_inspector    = $p_Properties->Button(
    -anchor      => 'w',
    -overrelief  => 'raised',
    -width       => 30,
    -state       => 'normal',
    -borderwidth => 1,
    -relief      => 'raised',
    -text        => '- Inspetor',
    -compound    => 'none'
)->pack( -fill => 'x' );
my $lst_inspector = $p_Properties->Scrolled(
    'Tree',
    -selectforeground  => 'RoyalBlue4',
    -selectborderwidth => 1,
    -borderwidth       => 1,
    -selectmode        => 'single',
    -relief            => 'flat',
    -scrollbars        => 'e',
    -background        => 'White',
    -borderwidth       => 0
  )->pack(
    -fill   => 'both',
    -expand => 1
  );

##TODO: This is only a test (HList)
$lst_inspector->add( 'Tk::MainWindow', -text => 'Tk::MainWindow' );
$lst_inspector->add( 'Tk::Frame',      -text => 'Tk::Frame' );
$lst_inspector->autosetmode();

###############################################
## Dock Properties
###############################################
my $btn_properties = $p_Properties->Button(
    -anchor      => 'w',
    -overrelief  => 'raised',
    -state       => 'normal',
    -borderwidth => 1,
    -relief      => 'raised',
    -text        => '- Propriedades',
    -compound    => 'none'
)->pack( -fill => 'x' );
my $w_NoteBook_166 = $p_Properties->NoteBook()->pack(
    -fill   => 'both',
    -expand => 1
);
## Tab General
my $w_NoteBookFrame_167 = $w_NoteBook_166->add(
    'w_NoteBookFrame_167',
    -label   => 'Geral',
    -state   => 'normal',
    -justify => 'left'
);
my $w_LabEntry_171 = $w_NoteBookFrame_167->LabEntry(
    -background  => 'White',
    -label       => 'Texto:',
    -labelPack   => [ -side => 'left', -anchor => 'n' ],
    -state       => 'normal',
    -borderwidth => 1,
    -justify     => 'left',
    -relief      => 'sunken'
)->pack( -fill => 'x' );

## Tab Size
my $w_NoteBookFrame_168 = $w_NoteBook_166->add(
    'w_NoteBookFrame_168',
    -label   => 'Tamanho',
    -state   => 'normal',
    -justify => 'left'
);

## Tab Callback
my $w_NoteBookFrame_169 = $w_NoteBook_166->add(
    'w_NoteBookFrame_169',
    -label   => 'Callback',
    -state   => 'normal',
    -justify => 'left'
);

###############################################
## Application Statusbar
###############################################
my $Statusbar = $mw->Frame(
    -borderwidth => 1,
    -relief      => 'sunken'
)->pack( -fill => 'x' );
my $w_Label_020 = $Statusbar->Label(
    -justify => 'left',
    -relief  => 'flat',
    -text =>
      'Perl Tk Development IDE version 0.1a - Daniel Vinciguerra <daniel-vinciguerra@hotmail.com>'
)->pack( -side => 'left' );
MainLoop;

###############################################
## Application Callbacks
###############################################
sub label {
    my $widget_str =
      "my \$mw_label0$c_label = \$Main -> Label (-text => 'Label $c_label' ) -> place( -x=>0, -y=>0 );\n";
    $widget_str .= "\$mw_label0${c_label}->bind('<Button-1>' => sub{ &widget_config('label', 'mw_label0$c_label') } );";
    $c_label++;

    # print $widget_str;
    eval($widget_str);
    print "ERROR: $@\n" if $@;
}

sub button {
    my $widget_str =
      "my \$mw_button0$c_button = \$Main -> Button (-text => 'Button $c_button' ) -> place( -x=>0, -y=>0 );";
    $widget_str .= "\$mw_button0${c_label}->bind('<Button-1>' => sub{ &widget_config('button', 'mw_button0$c_button') } );";
    $c_button++;

    # print $widget_str;
    eval($widget_str);
    print "ERROR: $@\n" if $@;
}

sub widget_config {
    my ($type, $name) = @_;
    my $dialog = $mw->DialogBox(
        -title     => "Perl Tk - Alert",
        -buttons => [ "OK" ]
    );
    $dialog->Label( -text => "$type - $name"  )->pack;

    my $item = $dialog->Show();    # ???
    print "$item\n";
}

sub init {

}
