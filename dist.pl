#!/usr/bin/perl -w 
#--------------------------------------------------
#	 
#	
#	$Header: /usr/local/cvsroot/perllib/template,v 1.4 2005/06/12 11:20:53 andrew Exp $
#	$Date: 2005/06/12 11:20:53 $
#--------------------------------------------------
# Version history
	#	$Log: template,v $
	#	Revision 1.4  2005/06/12 11:20:53  andrew
	#	Add -w
	#	
#--------------------------------------------------

=head1 NAME

=head1 SYNOPSIS

This writes a simple log to  a file

   category
   
   tesxt
   
   Note = t has changed to -c

=head1 DESCRIPTION

=head1 TO DO

 - add a delete or archive faciliy
 
 - add a head facility to type all items (or first n of all itmes0
   maybe use WANTARRAY
   
  

=cut

use strict ;
use warnings ;
use File::Spec ; 
use Getopt::Long ;
use Pod::Usage;
use Data::Dumper;
use POSIX qw/strftime/ ;
use Win32::Clipboard ;
use ab::FileTreeOO ;
use feature ":5.10" ;  


my $editor = "jedit" ;

use vars qw/%command_options/ ;

# Get the command optopns and warn user if they don't match
my $parse_result =  GetOptions (  \%command_options ,
       "man", 'help',    # standard otptions
       "c",              # type (cat) file
       "ca",             # type (cat) all matched files
       "cf",             # type (cat) file in formated form
       "e" ,             # edit
	   "v" ,             # var to use to locate files 
	   "d" ,			 # add date
	   "t" ,		     # add time
	   "new" ,           # create file
	   "dt" , 			 # time and date
	   "cl"  ,           #  copy to clipbard
	   
        ) ;

pod2usage (2) unless $parse_result ;
pod2usage (1) if $command_options{ help }  ;
pod2usage (2) if $command_options{ man } ;

#Get command line params

my $cat = shift ;
my $note = join " ",@ARGV ; # remaining args are the note
my $dir = $ENV { DIST } ;

if ( $cat )
{
	if ( defined $command_options{ ca } )
	{
        my @files = getcat ( $cat  ) ; # list of files 
		print Dumper ( \@files ) ;
		exit ;
	}
	
	
	
	$cat = getcat ( $cat) ;
	my $file = File::Spec->catfile ( $dir , $cat  ) ;
	if ( defined $command_options{ c } )
	{
		system "cat $file " ;
	}
	elsif ( defined $command_options{ cf } )
	{
		cat_formatted($file) ;
	}
	elsif ( defined $command_options{ e } )
	{
		system "$editor $file" ;
	}
	elsif ( defined $command_options{ cl } )
	{
		local $/ ;
		open my $F, $file or  die "Can't find $file" ;
		my $filecontent =  <$F> ;
		print $filecontent ;
		
		my $clipboard     = Win32::Clipboard();
		$clipboard->Set( $filecontent ); 
	}
	else
	{
		my $prefix = set_prefix() ;
		if ( $note eq '' )   # no note in coomand line => prompt
		{
		  print "Give note:" ;
		  while (<STDIN> )
		  {
			 last if /^$/ ;   #  break on empty string
			 file_note( $file, $prefix . $_ ) ;
			 print "Give note:" ;
		  }
		  
		}
		else
		{
		  open ( OUT, '>>' , $file ) || die "can't open £file " ;
		  file_note ( $file, "$prefix$note\n" ) ;
		}
	}

}
else
{
    # No cat given - just give a list of categories.
    print "\n" ;
    my $file = File::Spec->catfile ( $dir , "categories.dat"  ) ;
    open ( FH, $file ) or die "cant open $file " ;
    while ( <FH> )
    {
        print ;
    }
    
}
#-------------------------------------------------------------
sub file_note
{
	    my $file=shift ;
	    my $note=shift ;
		
		open ( OUT, '>>' , $file ) || die "can't open £file " ;
		print OUT "$note";
        close OUT ;
}
#-------------------------------------------------------------
sub set_prefix
{
	my $prefix = '' ;
	if (defined $command_options{ t } ) 
	{
		$prefix = get_timedate ( "%H:%M " ) ;
	}
	elsif (defined $command_options{ d } ) 
	{
		$prefix = get_timedate ( "%a %d-%b-%y " ) ;
	}
	elsif (defined $command_options{ dt } ) 
	{
		$prefix = get_timedate() . " " ;
	}
	
	print "p=$prefix\n" ;
	
	return $prefix ;
}  
#-------------------------------------------------------------
sub get_timedate
{
	my $format = shift || "%y-%m-%d %H:%M (%a %d-%b)" ;
	strftime ($format, localtime() );
}
#-------------------------------------------------------------
sub cat_formatted
{
	my $file = shift ;
	open my $FH,$file || die "can;t opne $file" ;
	while (<$FH>)
	{
		if ( /^\S/ )
		{
			print "\n\n";
		}
		print ;
	}
	
}
#-------------------------------------------------------------
sub getcat
{
	my $category= shift ;
	my $tree =  ab::FileTreeOO->new () ;
my @files = $tree->in_env ("dist", $category) ;

my $count = scalar @files ;
print Dumper( \@files ) ;
if ($count >1 ) 
{
	say "Warning - multiple files "  ;
	say "=========+" ;
}
if ($count ==0 ) 
{
	say "Warning - new file "  ;
	say "=========+" ;
	exit unless  $command_options{ new } ;
	push @files, $category ;    # default to given category
}
    if ( wantarray )
	{
	  return @files  ;
	}
	else
	{
	  return $files [0] ;
	}
}


