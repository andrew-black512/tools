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
my $domain = 'zoom|whereby|teams\.microsoft' ;

my $file = shift ;
my $mode = shift // '' ;

my $fullfile = $ENV{"MEET"}. "/meetids/" . $file ;
my $notefile = $ENV{"MEET"}. "/notes/" . $file ;
open (my $FH, $fullfile ) or do_help($ENV{"MEET"}. "/meetids/") ;
my $url ;
while (<$FH>) {
  if (/https.*$domain/) {
    chomp ;
    $url = $_ ;
  }
}
say $url ;
if ($mode ne 'q') {
    system "firefox $url" ;
}
## TODO - mayb check file exists
##system "atom $notefile" ;

#-----------------------------------------
sub do_help {
  my $meet_dir = shift ;
   say "Meet file not found. Try" ;
   system "ls -lrt $meet_dir" ;
   exit ;
}
