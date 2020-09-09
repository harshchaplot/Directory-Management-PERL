use feature qw(switch say);
no warnings qw( experimental::smartmatch );

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
				while ($file = readdir DIR)  
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