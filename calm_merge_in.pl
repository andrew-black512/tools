#!/usr/bin/perl -w

=head1 NAME

xxxxx.pl -

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 TO DO

=cut

use strict ;
use warnings ;
use 5.10.0 ;
use Data::Dumper ;
use File::Spec ;

#--------
my $lastline ;
sub merge_in {
    my $fh=shift ;
    my $time=shift ;
    say "Merge in $time" ;
    $lastline = <$fh> unless $lastline ;
    #say $lastline ;
    while(  $lastline lt $time )
    {
        print $lastline  ;
        $lastline = <$fh>
    }
}
#--------
my $merge_file = shift ;
open(my $FH, "<", $merge_file)
                    or die "Can't open '$merge_file' : $!" ;

while (<> ) {
    if (/^ ( \d\d:\d\d ) /x ) {
        merge_in $FH, $1 
    }
}