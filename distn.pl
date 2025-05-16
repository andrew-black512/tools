#!/usr/bin/perl -w

=head1 NAME


=head1 SYNOPSIS

This writes a simple log to  a file

   category

   tesxt

   Note = t has changed to -c

=head1 DESCRIPTION

=head2 Outputs

Formatted dump - at present inserts blank lines before unindented lines
(i.e. keeping indented blocks together.

=head1 TO DO
#TODO sort out editors (eg gui v. CL)
=head2 Now

 - -c doesnt seem to work with -last.
 - investigate sort order (suspect last doesnt work )

=head2 Done

=head2 Later

 - sort the otions into order. Maybe use a better getops package.


  - add a delete or archive faciliy

 - add a head facility to type all items (or first n of all itmes0
   maybe use WANTARRAY



=cut

use strict ;
use warnings ;
use File::Spec ;
use File::Copy;
use Getopt::Long ;
use Pod::Usage;
use Data::Dumper;
use POSIX qw/strftime/ ;
use File::Find::Rule ;
use feature ":5.10" ;


my $editor = "jedit" ;
my $term_reg = qr/^ \.\. $/x ;

use vars qw/%command_options/ ;

# Get the command optopns and warn user if they don't match
my $parse_result =  GetOptions (  \%command_options ,
    	# Try to keep these in alphabetical order

       "man", 'help',    # standard otptions
       "a",              # archive (rename to DIST/../archive
       "c",              # type (cat) file
       "ca",             # type (cat) all matched files  TODO not implemented
                         #   currenlty lists a names of matching files.
       "cf",             # type (cat) file in formated form
       "e" ,             # edit
	   "v" ,             # var to use to locate files TODO - not implemented
	   "d" ,			 # add date
	   "prefix=s",       # prefix (subdirectory to look in).
	   "last" ,          # use last file found (particulary good with dated files)
	   "t" ,		     # add time
	   "new" ,           # create file
	   "dt" , 			 # time and date
	   "cl"  ,           #  copy to clipbard - Win only

        ) ;

pod2usage (2) unless $parse_result ;
pod2usage (1) if $command_options{ help }  ;
pod2usage (2) if $command_options{ man } ;

#Get command line params



my $cat = shift ;
my $note = join " ",@ARGV ; # remaining args are the note
my $dir = File::Spec->catdir(
        $ENV { DIST } ,
        $command_options{ prefix } // ''
      );

my $config = getconfig();

if ( $cat )
{
	if ( defined $command_options{ ca } )
	{
        my @files = getcat ( $cat  ) ; # list of files
		print Dumper ( \@files ) ;
		exit ;
	}

	# look into dist.ini to sse if there is a fileloc for this cat...
	my $configcat = $$config {'file'} { $cat } ;
	if ( defined $configcat ) {
	  $cat = $configcat ;
	  say "Using shortcut file '$configcat'" ;
    } else {
	$cat = getcat ( $cat) ;
    }
    # pre Oct 2019 it was relative to $dir, via extra param to rel2abs
	my $file = $cat ;
  #File::Spec->rel2abs (  $cat, $ENV{'HOME'} ) ;

	# Try to keep these in alphabetical order
	if ( defined $command_options{ a } )
	{
	    my $dest = File::Spec->catdir( $ENV{dist},'../archive' ) ;
	    say "moving $file to $dest" ;
	    move( $file , $dest ) ;

	}
	elsif ( defined $command_options{ c } )
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
	elsif ( defined $command_options{ v } )
	{
		my $term_editor = 'vi' ;
		my $tmp_file = '/tmp/distin' ;
		system "$term_editor $tmp_file" ;
		system "cat $tmp_file >> $file " ;
		system "rm $tmp_file -v" ;
		
	}
	elsif ( defined $command_options{ cl } )
	{
    #TODO clip is windows ....
		local $/ ;
		open my $F, $file or  die "Can't find $file" ;
		my $filecontent =  <$F> ;
		eval {
		    require Win32::Clipboard;
		    print "pasting to clipboard\n" ;

		    my $clipboard     = Win32::Clipboard();
		    $clipboard->Set( $filecontent );
		} ;
		print "error in clipboard paste " if $@;
	}
	else
	{
		my $prefix = set_prefix() ;
		if ( $note eq '' )   # no note in coomand line => prompt
		{
		  print "Give note:" ;
		  while (<STDIN> )
		  {
			 last if /$term_reg/ ;   #  break on terminating strinmg
			 file_note( $file, $prefix . $_ ) ;
			 print "Give note:" ;
		  }

		}
		else
		{
		  open ( OUT, '>>' , $file ) || die "can't open $file " ;
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

		open ( OUT, '>>' , $file ) || die "can't open $file " ;
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
  # TODO allow a way of allowing .*$category
	my @files = File::Find::Rule-> file()
				 -> name ( qr/^$category/ )
				 -> relative
				 -> name ( qr/[^~#]$/)   # ignore edit backups
        # -> name ( qr/^\w/)   # TODO ignore GIT and other , files
	             -> in ( $dir ) ;


my $count = scalar @files ;
print Dumper( \@files ) ;
if ($count >1 )
{
	say "Warning - multiple files "  ;
	say "=========+" ;
}
if ($count ==0 )
{
	say "Warning - new file "  ;  #TODO-1 silly warning
	say "=========+" ;
	exit unless  $command_options{ new } ;
	push @files, $category ;    # default to given category
}
  @files = sort @files ;
    if ( wantarray )
	{
	  return @files  ;
	}
	else
	{

	  my $using_file = $files [ $command_options{ last }  ? -1 : 0 ] ;
    $using_file = File::Spec->rel2abs (  $using_file, $dir) ;

	  say "Using $using_file " ;
	  return $using_file ;


	}
}
#-------------------------------------------------------------
sub getconfig
{
	my $config = {} ;
# read configuration file
my $config_file =  $ENV{HOME} . '/dist.ini';
    open ( my $FH, $config_file ) or die "cant open $config_file " ;
    while ( <$FH> ) {
    	s/#.*// ;
        next if /^\s*$/ ;
    	chomp;
		
        my ($cat, $file) = split /:/ ;
		$cat =~ s/\s//g     ;   # ignore spaces around key
        $file =~ s/^\s+//  ;
        $file =~ s/\s+$//  ;
        $file =~ s/~/ $ENV{HOME} /e ;
        ##say "Read $cat, $file" ;
		$$config {'file'} { $cat } = $file ;

    }

	#print Dumper (\$config) ;
    return $config ;
}
=head 1

Spec for change
 - read a file
       dist dir .distconfig
 - strip comments
 - format
     keyword  space file
     (deosnt allow for space in file

Return has
    file => keyword => location
    (allows for other options later)
=head 2

$config->file($file);

#Read command line args (conflicts with main program
#$config->getopt();
return $config ;
}
= cut
