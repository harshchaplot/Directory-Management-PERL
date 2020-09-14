use feature qw(switch say);
use Tk;
use strict;
no warnings qw( experimental::smartmatch );

my $mw = MainWindow->new;

$mw->Label(-text => 'Enter Directory Name')->pack;
my $dirname = $mw->Entry(-width => 20);
$dirname->pack;
$mw->Label(-text => 'Enter New Directory Name For Renaming')->pack;
my $newdirname = $mw->Entry(-width => 20);
$newdirname->pack;

$mw->Button(
    -text    => 'Create Directory',
    -command => sub {create_dir($dirname)},
)->pack;
$mw->Button(
    -text    => 'List all Director(y)(ies)',
    -command => sub { list_dir($dirname) },
)->pack;
$mw->Button(
    -text    => 'List all File(s)',
    -command => sub { list_file($dirname) },
)->pack;
$mw->Button(
    -text    => 'Rename Directory',
    -command => sub { rename_dir($dirname,$newdirname) },
)->pack;
$mw->Button(
    -text    => 'Delete a Directory',
    -command => sub { delete_dir($dirname) },
)->pack;
MainLoop;

sub create_dir {
	my ($dir_name) = @_;
	my $dir = $dir_name->get;
	if(mkdir($dir)){
		$mw->Label(-text => "Directory created \n")->pack;
		print "Directory created \n";
	}
	else{
		$mw->Label(-text => "'$dir' directory cannot be created.\n")->pack;
		print "'$dir' directory cannot be created.\n";
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
		$mw->Label(-text => "'$temp'")->pack;
		closedir DIR; 
	}
	else{
		$mw->Label(-text => 'No Directory, $!')->pack;
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
		$mw->Label(-text => "'$temp'")->pack;
		closedir $dh; 
	}
	else{
		$mw->Label(-text =>  "Could not open '$dir' for reading '$!'\n")->pack;
	}
}

sub delete_dir {
	my ($dir_name) = @_;
	my $dir = $dir_name->get;
	if(rmdir($dir)){
		$mw->Label(-text => "Directory removed \n")->pack;
	}
	else{
		$mw->Label(-text => "Couldn't remove $dir directory, $!\n")->pack;   
	}
}

sub rename_dir {
	my ($dir_name,$new_dir_name) = @_;
	my $dir = $dir_name->get;
	my $newdir = $new_dir_name->get;
	if(rename($dir,$newdir)){
		$mw->Label(-text => "Directory renamed\n")->pack;
	}
	else{
		$mw->Label(-text => "Error in renaming")->pack;
	}
}