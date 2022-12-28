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
sub open_merge {
     open(my $FH, "<", $filname)
                    or die "Can't open < $filename: $!";


}
#--------
my $merge_file = shift ;

