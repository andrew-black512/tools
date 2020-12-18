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

Content-Type: text/plain; charset="UTF-8"
Content-Type: text/html; charset="UTF-8"

=cut

use strict ;
use warnings ;
use feature ":5.10" ;
use Data::Dumper ;

say '' ;
#TODO Kludge
push @ARGV, '/home/andrew/.thunderbird/98eg4dmp.default/ImapMail/mail.aa.net.uk/INBOX.sbd/Meet';
my $state = 1 ;
while (<>)
{
    if ( m|Content-Type: text/(\w*)| ) {
        #say $1 ;
        $state = ($1 eq 'plain' ) ;
        #say $state ;
    }
    next unless $state ;
 
     if ( /^Subject:/ ) {
        say "\n==================================================";
    	print;
    	next;
    }
     if ( /Topic:|Time:/ ) {
        say '' ;
    	print;
    	next;
    }
   if ( /Meeting ID:|https/ ) {
   	    #say '' ;
    	print;
    	next;
    }

}
