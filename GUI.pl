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
    -command => sub { exit },
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

while(1<2){
	print "Enter 1 for creating a directory\n";
	print "Enter 2 for listing all directory\n";
	print "Enter 3 for listing all files\n";
	print "Enter 4 for deleting a directory\n";
	print "Enter anything else to close the program\n";

	chomp(my $choice = <>);

	given($choice){
		when('1'){
			say 'Creating directory';
			say 'Enter the name of the directory to be created';
			# Creates dir in cwd
			chomp(my $dirname = <>);
			if(mkdir($dirname)){
				print "Directory created \n";
			}
			else{
				print "No $dirname directory, $!\n";
			}
		}
		when('2'){
			say 'Listing directory';
			say 'Enter the path from where you want to list all directories';
			# input format /home/harsh/Desktop
			chomp(my $dirname = <>);   
			if(opendir(DIR, $dirname)){
				while (my $file = readdir DIR)  
				{   
				    print "$file\n";   
				}   
				closedir DIR; 
			}
			else{
				print "No directory, $!\n";
			}
			
		}
		when('3'){
			say 'Listing all files';
			say 'Enter the path from where you want to list all files';
			# input format /home/harsh/Desktop
			chomp(my $dirname = <>);
			if(opendir my $dh, $dirname){
				while (my $content = readdir $dh) 
				{ 
					say $content; 
				}
				closedir $dh; 
			}
			else{
				print "Could not open '$dirname' for reading '$!'\n";
			}
		}
		when('4'){
			say 'Deleting directory';
			say 'Enter the directory you want to delete';
			# Deletes dir in the cwd
			chomp(my $dirname = <>);
			if(rmdir($dirname)){
				print "Directory removed \n";   
			}
			else{
				print "Couldn't remove $dirname directory, $!\n";    
			}
		}
		default{
			say 'Exiting from the program';
			last;
		}
	}
}