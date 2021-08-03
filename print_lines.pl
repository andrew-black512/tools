#!/usr/bin/perl -w

=head1 NAME

print_lines.pl - Prints the first N lines of each file.

=head1 SYNOPSIS

        perl list_lines.pl  [opts]  files.....

          -lines   num lines to print per file
          -html    format in HTML
          -moin    format for MOIN
          -nocomm    ignore comments

Moving towarda a modularised version


=head1 OPTIONS

Options will go in here


=head1 DESCRIPTION

... Full Desc to go here ....

=head TODO

 would be better to treat each file seperately ratehr tahn
 use the <> operator.

 Remove leading and traning whitespae
 Ignore coment lines #
 Handle missing files gracefully (write to STDERR?)


=cut
#------------------------------------------------------------------------


use strict ;
use Getopt::Long ;
use Pod::Usage;
use Data::Dumper ;

use vars qw/%command_options/ ;
use vars qw/$format_file $format_pre_file  $format_post_file/ ;

# Get the command optopns and warn user if they don't match
my $parse_result =  GetOptions (  \%command_options ,
       "lines=n",
       "html!" ,
       "man", 'help',    # standard otptions
       "list",
       "moin" ,
       "nocomm" ,
        ) ;

pod2usage (2) unless $parse_result ;
pod2usage (1) if $command_options{ help }  ;
pod2usage (2) if $command_options{ man }  ;



my $max_lines =  $command_options{lines} || 5 ;

#my $format = '   %4d  %s' ;
my $format = '     %s' ;

&setup_formats;
&do_list ;

#==================================================
sub setup_formats
{
   if  ( $command_options{html} )
   {
        $format_file = "<h2>%s</h2>\n" ;
        $format_pre_file  = "<pre>\n" ;
        $format_post_file  = "</pre>\n" ;
   }
   elsif  ( $command_options{moin} )
   {
        $format_file = "'''%s'''\n" ;
        $format_pre_file  = "{{{\n" ;
        $format_post_file  = "}}}\n" ;
   }
   else
   {
        $format_file = "%s\n" ;
        $format_pre_file  = "" ;
        $format_post_file  = "\n" ;
   }
}

#==================================================
sub do_list
{
   my @filelist ;
   if  ( $command_options{list} )
   {                    # gets a list of files from STDIN
       while ( <STDIN> )
       {
           chomp ;
           push @ARGV, $_ ;
       }
   }
   else
   {
       @ARGV = map {glob }  @ARGV ;  # expand wildcards (needed for Win32)
   }
   print_heads (\@ARGV) ;
}
#==================================================
# Below here is a candidate for a module.
# Stuff that is configurable might be better of using Mooose
# For now make it Thatcherite (the is no alternative)
sub print_heads
{
	my $filelistref = shift ;
	my @filelist = @{$filelistref} ;
	print Dumper \@filelist ;

#my $file ;
print "List of files\n"  ;
for my $file ( @$filelistref )
{
   print "   $file\n" ;
}

print "\n\n" ;


FILE:
foreach my $f (  @$filelistref )
{
	printf  $format_file ,  $f ;
    print $format_pre_file ;

	open ( my $FH, '<', $f) or die "can't open $f " ;
    my $lineno=0;
	while ( <$FH> )
	{

	   if ( $lineno > $max_lines )
       {
		   print " .... \n" ;  # Say there is supressed data
           next FILE ;
       }
       next if /^#/ && $command_options{nocomm} ;
	   $lineno ++ ;

       #printf ( $format, $. , $_) ;
       printf ( $format, $_) ;
	}


    } continue
	{
		    print $format_post_file ;

	}
}
