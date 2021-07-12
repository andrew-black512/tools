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
my @wanted_buses = (40,176,185,484,343) ;
my %bus_data ;
say Dumper \@wanted_buses ;
while (<>) {
  if (/Routes/) {
    $state = 'Extra ' if /extra/ ;
    $state = 'Morn ' if /0730/ ;
    $state = 'Aft ' if /1430/ ;
    #say $state
  } else {

    for my $busno ( @wanted_buses) {
       if (/\b$busno\b/) {
           #say "found $busno" ;
           $bus_data {$busno} .= $state  ;
      }
    }
  }
}
say Dumper \%bus_data ;
