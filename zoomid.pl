#!/usr/bin/perl -w

=head1 NAME

**file - **desc

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 TO DO

=head1 SAMPLE

Topic: St John's East Dulwich's Coffee Morning
Time: Apr 29, 2020 11:00 AM London

Join Zoom Meeting
https://us02web.zoom.us/j/87048507656

Meeting ID: 870 4850 7656


=cut

use strict ;
use warnings ;
use feature ":5.10" ;
use Data::Dumper ;

say '' ;
while (<>)
{
     if ( /Topic:|Time:/ ) {
    	print;
    	next;
    }
   if ( /Meeting ID:|https/ ) {
   	    say '' ;
    	print;
    	next;
    }

}