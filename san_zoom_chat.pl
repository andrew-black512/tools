#!/usr/bin/perl -w

=head1 NAME

xxxxx.pl -

=head1 SYNOPSIS

11:06:19 From Andrew Black To Everyone : text .......

=head1 DESCRIPTION

=head1 TO DO

=cut

use strict ;
use warnings ;
use 5.10.0 ;
use Data::Dumper ;
use File::Spec ;

while (<>) {
  # will fail if someone has : in name or if text has :
  s/(\d\d:\d\d:\d\d \s*) ([^:]*) ://x ;
  # TODO save time etc
  print ;
}
