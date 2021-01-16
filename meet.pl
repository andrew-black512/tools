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

# poss config
my $domain = 'zoom|whereby' ;

my $file = shift ;
my $fullfile = $ENV{"MEET"}. "/" . $file ;
open (my $FH, $fullfile ) or die "cant find $fullfile" ;
my $url ;
while (<$FH>) {
  if (/https.*$domain/) {
    chomp ;
    $url = $_ ;
  }
}
say $url ;
system "firefox $url" ;
