#!/usr/bin/perl
#--------------------------------------------------
#	 
#	
#	$Header: /usr/local/cvsroot/perllib/mod_grep.pl,v 1.4 2005/07/09 11:25:50 andrew Exp $
#	$Date: 2005/07/09 11:25:50 $
#--------------------------------------------------
# Version history
	#	$Log: mod_grep.pl,v $
	#	Revision 1.4  2005/07/09 11:25:50  andrew
	#	(add to do)
	#	
	#	Revision 1.3  2005/07/05 11:07:42  andrew
	#	Remove duplicates
	#	
	#	Revision 1.2  2005/07/05 10:38:29  andrew
	#	Use Getopt::Declare.   Add -f to display full filenames
	#	
	#	Revision 1.1  2005/04/12 14:04:17  andrew
	#	Find what modules you have - Initial version
	#	
	#	Revision 1.1  2004/09/02 07:18:32  andrew
	#	First version
	#	
#--------------------------------------------------

=head1 NAME
mod_grep.pl - lists modules on system mathcing a regexp

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 TODO

    $mod=~s/^$File::Find::topdir\/?//;  isnt very smart 
    as it might have \ it (esp on Windoze)
    
    Remove . from @INC

=cut

use strict ;
use warnings ;
use File::Find ;

my $oldValue = '' ;
sub head_if_changed
{
   my $newValue= shift ;
	 if ( $newValue ne $oldValue )
	 {
	   print "\n" ;
	   print "$newValue\n" ;
	   $oldValue = $newValue ;
	 }
}

=head1 IGNORE

my $args =new Getopt::Declare q(
	-f	print filename only
		eg less `mod_grep.pl xxxxxxx`
	
	-l	list @INC too 
) or exit ;

=cut

my $args = {} ;

if (defined($$args{'-l'}))
{
	print "Module directories are :\n" ;
	print join "\n",@INC ;
	print "\n\n" ;
	print "==========================\n" ;
}
my $reg  = shift || '.' ;  # default to match anything 

find(  \&mod_sub , @INC) ;


#-------------------------------------------------
#    We need to prune files beginigng with (eg) 5 becuase 
#    of the same directory being twice in @INC
#    /usr/lib/perl5/site_perl/5.8.0  Mail::Sendmail
#    /usr/lib/perl5/site_perl    5.8.0::Mail::Sendmail


sub mod_sub
{
    return unless /.pm$/i;
    my $fullfile=$File::Find::name;
    
    my $mod =  $fullfile ;
		$mod=~s/^$File::Find::topdir\/?//;  #leave Mod/mod.pm
		return if $mod =~ /^5/ ;
		return if $mod =~ /^i386/ ;

		$mod=~s/\.pm$//i;
		$mod=~s!/!::!g;
		if  ($mod=~ /$reg/oi)
		{
		    if (defined($$args{'-f'}))
		    {
			  print "$fullfile\n" ;
		    }
		    else
		    {
		  head_if_changed $File::Find::topdir ;
		  print "  $mod\n" ;
		    }
		}
}
