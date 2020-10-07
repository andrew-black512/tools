#!/usr/bin/perl -w

=head1 NAME

xxxxx.pl -

=head1 SYNOPSIS

=head1 DESCRIPTION

looks for following lines
Routes with extra buses being provided:
Routes with school priority buses running between 0730 and 0900 (* denotes until 0930):
Routes with school priority buses running between 1430 and 1630:

=head1 TO DO

=cut

use strict ;
use warnings ;
use 5.10.0 ;
use Data::Dumper ;
use File::Spec ;

my $state ;
while (<>) {
  if (/Routes/) {
    $state = 'E' if /extra/ ;
    say $state 
  } else {
    # else...
  }
  # body. ..
}
