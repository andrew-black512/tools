#!/usr/bin/perl -w

=head1 NAME

**file - **desc

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 TO DO

=cut

use strict ;
use warnings ;
use feature ":5.10" ;
use Data::Dumper ;

my %prefix = (
   1 => '# '    ,       # Them
  -1 => '     ' ,       # Me
) ;

my $direction = 1 ;
while (<>) {
    if (/account_circle/) {
       $direction = - $direction ;
       #print Dumper $direction ;
       next ;
    }
    if (/welcome to CALM webchat/) {
       $direction = 1 ;
    }
    if (/hi calm/i) {   # I try to start chats with this if they are late
       $direction = -1 ;
    }
    next if /^$/ ;
    next if /^\d\d:\d\d/ ; # TODO preserve time
    s/'/''/g ;  # apostrophes mess up the colouring
    print $prefix{ $direction } . $_ ;
}
