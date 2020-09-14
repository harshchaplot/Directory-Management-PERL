use feature qw(switch say);
use Tk;
use strict;
no warnings qw( experimental::smartmatch );

my $mw = MainWindow->new(-title => "CRUD Application");
$mw->geometry( "1000x600" );

$mw = $mw->Frame(-borderwidth => 1.5, -relief => "groove")->pack(-side => "top", -fill => 'x');

$mw->configure(-foreground => "black", -background => "white");

$mw->Label(-text => 'Enter Directory Name')->pack(-side => "top")->configure(-foreground => "black", -background => "white");
my $dirname = $mw->Entry(-width => 20);
$dirname->pack(-side => "top")->configure(-foreground => "black", -background => "white");

$mw->Label(-text => '')->pack()->configure(-foreground => "black", -background => "white");

$mw->Label(-text => 'Enter New Directory Name For Renaming')->pack(-side => "top")->configure(-foreground => "black", -background => "white");
my $newdirname = $mw->Entry(-width => 20);
$newdirname->pack(-side => "top")->configure(-foreground => "black", -background => "white");

$mw->Label(-text => '')->pack()->configure(-foreground => "black", -background => "white");

$mw->Button(
    -text    => 'Create Directory',
    -command => sub {create_dir($dirname)},
)->pack(-side => "left")->configure(-foreground => "black", -background => "steelblue");

$mw->Button(
    -text    => 'List all Director(y)(ies)',
    -command => sub { list_dir($dirname) },
)->pack(-side => "left")->configure(-foreground => "black", -background => "steelblue");

$mw->Button(
    -text    => 'List all File(s)',
    -command => sub { list_file($dirname) },
)->pack(-side => "left")->configure(-foreground => "black", -background => "steelblue");

$mw->Button(
    -text    => 'Rename Directory',
    -command => sub { rename_dir($dirname,$newdirname) },
)->pack(-side => "left")->configure(-foreground => "black", -background => "steelblue");

$mw->Button(
    -text    => 'Delete a Directory',
    -command => sub { delete_dir($dirname) },
)->pack(-side => "left")->configure(-foreground => "black", -background => "steelblue");

$mw->Label(-text => '')->pack(-side => "bottom")->configure(-foreground => "black", -background => "white");

MainLoop;


sub create_dir {
	my ($dir_name) = @_;
	my $dir = $dir_name->get;
	if(mkdir($dir)){
		$mw->Label(-text => "Directory created \n")->pack(-side => "bottom")->configure(-foreground => "black", -background => "white");
	}
	else{
		$mw->Label(-text => "'$dir' directory cannot be created.\n")->pack(-side => "bottom")->configure(-foreground => "black", -background => "white");
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
		$mw->Label(-text => "$temp")->pack(-side => "bottom")->configure(-foreground => "black", -background => "white");
		closedir DIR; 
	}
	else{
		$mw->Label(-text => 'No Directory, ' + $dir)->pack(-side => "bottom")->configure(-foreground => "black", -background => "white");
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
		$mw->Label(-text => "$temp")->pack(-side => "bottom")->configure(-foreground => "black", -background => "white");
		closedir $dh; 
	}
	else{
		$mw->Label(-text =>  "Could not open '$dir' for reading\n")->pack(-side => "bottom")->configure(-foreground => "black", -background => "white");
	}
}

sub delete_dir {
	my ($dir_name) = @_;
	my $dir = $dir_name->get;
	if(rmdir($dir)){
		$mw->Label(-text => "Directory removed \n")->pack(-side => "bottom")->configure(-foreground => "black", -background => "white");
	}
	else{
		$mw->Label(-text => "Couldn't remove $dir directory\n")->pack(-side => "bottom")->configure(-foreground => "black", -background => "white");   
	}
}

sub rename_dir {
	my ($dir_name,$new_dir_name) = @_;
	my $dir = $dir_name->get;
	my $newdir = $new_dir_name->get;
	if(rename($dir,$newdir)){
		$mw->Label(-text => "Directory renamed\n")->pack(-side => "bottom")->configure(-foreground => "black", -background => "white");
	}
	else{
		$mw->Label(-text => "Error in renaming")->pack(-side => "bottom")->configure(-foreground => "black", -background => "white");
	}
}