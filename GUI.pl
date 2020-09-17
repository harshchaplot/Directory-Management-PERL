use feature qw(switch say);
use Tk;
use strict;
use Tk::Pane;
no warnings qw( experimental::smartmatch );

my $mw = MainWindow->new(-title => "Directory Management (CRUD) Application");
$mw->geometry( $mw->screenwidth."x".$mw->screenheight );
$mw->configure(-foreground => "black", -background => "white");

my $frame = $mw->Frame(-borderwidth => 1.5, -relief => "groove")->pack(-side => "top", -fill => 'x');

$frame->configure(-foreground => "black", -background => "white");

$frame->Label(-text => 'Enter Directory Name')->pack(-side => "top")->configure(-foreground => "black", -background => "white");
my $dirname = $frame->Entry(-width => 20);
$dirname->pack(-side => "top")->configure(-foreground => "black", -background => "white");

$frame->Label(-text => '')->pack()->configure(-foreground => "black", -background => "white");

$frame->Label(-text => 'Enter New Directory Name For Renaming')->pack(-side => "top")->configure(-foreground => "black", -background => "white");
my $newdirname = $frame->Entry(-width => 20);
$newdirname->pack(-side => "top")->configure(-foreground => "black", -background => "white");

$frame->Label(-text => '')->pack()->configure(-foreground => "black", -background => "white");

$mw = $mw->Frame(-height=>'10', -width=>'30', -relief=>'groove', -borderwidth=>'3' )->pack( -expand=>1, -fill=>'both', -pady=>'0');
$mw = $mw->Scrolled('Frame', -foreground => 'white', -background => 'white', -relief => 'groove', -scrollbars=>'se')->pack(-expand =>1, -fill=>'both');

$mw->Button(
    -text    => 'Create Directory',
    -command => sub {create_dir($dirname)},
)->pack(-side => "top")->configure(-foreground => "black", -background => "steelblue");

$mw->Button(
    -text    => 'List all Director(y)(ies)',
    -command => sub { list_dir($dirname) },
)->pack(-side => "top")->configure(-foreground => "black", -background => "steelblue");

$mw->Button(
    -text    => 'List all File(s)',
    -command => sub { list_file($dirname) },
)->pack(-side => "top")->configure(-foreground => "black", -background => "steelblue");

$mw->Button(
    -text    => 'Rename Directory',
    -command => sub { rename_dir($dirname,$newdirname) },
)->pack(-side => "top")->configure(-foreground => "black", -background => "steelblue");

$mw->Button(
    -text    => 'Delete a Directory',
    -command => sub { delete_dir($dirname) },
)->pack(-side => "top")->configure(-foreground => "black", -background => "steelblue");

$mw->Label(-text => '')->pack(-side => "bottom")->configure(-foreground => "black", -background => "white");

MainLoop;


sub create_dir {
	my ($dir_name) = @_;
	my $dir = $dir_name->get;
	if(mkdir($dir)){
		$mw->Label(-text => "Directory created \n")->pack(-side => "top")->configure(-foreground => "black", -background => "white");
	}
	else{
		$mw->Label(-text => "'$dir' directory cannot be created.\n")->pack(-side => "top")->configure(-foreground => "black", -background => "white");
	}
}

sub list_dir {
	# input format /home/harsh/Desktop
	my ($dir_name) = @_;
	my $dir = $dir_name->get;
	if(opendir(DIR, $dir)){
		my $temp = "";
		while (my $file = readdir DIR)  
		{   
		    $temp = $temp.$file;
		    $temp = $temp."\n";
		}   
		$mw->Label(-text => "$temp")->pack(-side => "top")->configure(-foreground => "black", -background => "white");
		closedir DIR; 
	}
	else{
		$mw->Label(-text => 'No Directory, ' + $dir)->pack(-side => "top")->configure(-foreground => "black", -background => "white");
	}
}

sub list_file {
	# input format /home/harsh/Desktop
	my ($dir_name) = @_;
	my $dir = $dir_name->get;
	if(opendir my $dh, $dir){
		my $temp = "";
		while (my $content = readdir $dh) 
		{ 
			$temp = $temp.$content;
		    $temp = $temp."\n";
		}
		$mw->Label(-text => "$temp")->pack(-side => "top")->configure(-foreground => "black", -background => "white");
		closedir $dh; 
	}
	else{
		$mw->Label(-text =>  "Could not open '$dir' for reading\n")->pack(-side => "top")->configure(-foreground => "black", -background => "white");
	}
}

sub delete_dir {
	my ($dir_name) = @_;
	my $dir = $dir_name->get;
	if(rmdir($dir)){
		$mw->Label(-text => "Directory removed \n")->pack(-side => "top")->configure(-foreground => "black", -background => "white");
	}
	else{
		$mw->Label(-text => "Couldn't remove $dir directory\n")->pack(-side => "top")->configure(-foreground => "black", -background => "white");   
	}
}

sub rename_dir {
	my ($dir_name,$new_dir_name) = @_;
	my $dir = $dir_name->get;
	my $newdir = $new_dir_name->get;
	if(rename($dir,$newdir)){
		$mw->Label(-text => "Directory renamed\n")->pack(-side => "top")->configure(-foreground => "black", -background => "white");
	}
	else{
		$mw->Label(-text => "Error in renaming")->pack(-side => "top")->configure(-foreground => "black", -background => "white");
	}
}