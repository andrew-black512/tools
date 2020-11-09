#!/usr/bin/perl -w

=head1 NAME

tbird.pl - list Thunderbird drafts

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 TO DO

=cut

use strict ;
use warnings ;
use 5.10.0 ;
use Data::Dumper ;
use File::Spec ;

my $tbird_local_dir = 'C:\Users\andrew\AppData\Roaming\Thunderbird\Profiles\v6lq35j1.default\Mail\Local Folders' ;
my @folders =  (
    #'Drafts-1' ,
    'Unsent Messages'      # Outbox
    ) ;

say '' ;

foreach my $folder ( @folders ) {
   say $folder ;
   my $filename = File::Spec->catfile ( $tbird_local_dir , $folder  ) ;
   open my $F, '<', $filename or  die "Can't find $filename" ;
   while (<$F>) {
       print "   $_"  if /Subject:/ ;
   }
   say '' ;
}
