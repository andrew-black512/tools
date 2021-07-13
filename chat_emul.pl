#!/usr/bin/perl -w 
#--------------------------------------------------

=head1 NAME

**file - **desc

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 TO DO

 - get it to wait approx .5 sec before replying (maybe slightly random)
 - make phrases more configurable (eg different sets or from a text file)
 - optionally log my output to a file  (eg if I am taking a 

=cut

use strict ;
use warnings ;
use feature ":5.10" ; 

#-----------------------------------------

my @responses = (
 #'Sounds like a good idea'      ,
 #'Can you have a look at that' ,
 #'Can I get back to you on that' ,
 'sorry to hear about that ' ,
 'maybe have some herb tea first' ,
 'Ask one of the wellbeing assistants to make a herb tea' 
  ) ;

my $terminate_reg = qr/^ \.\. $/x ;


#=--------------------------------------------------
my $who = shift // "Wellbeing operative";
my $me = 'Andrew ' ;

print format_name($me) ;
while (<STDIN>) {
    last if /$terminate_reg/ ;   
    
	
    if ( s/ \+ (\d* \.? \d*) (.* :)? //x ) {
    	# Takes a line "+nnn [ : text ] and
    	#  - waits for nnn secs and repeats back "text"
        my $wait = $1 ; ###* 60;
        say "sleep for $wait" ;
        sleep $wait;
        say format_name($who) . $_  ;

    } else {
        say format_name($who) . random_phrase()  ;
    }
    print format_name($me) ;

}
say '' ;


say 'Goodbye' ;


sub format_name {
  my $n = shift ;
  return sprintf "%-10s : 	" ,$n ;
}

sub random_phrase {
     my $i = int ( rand ( scalar @responses ) ) ;
     return $responses[ $i ] ;
}
