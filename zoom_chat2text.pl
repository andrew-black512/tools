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

my $select = shift  ;
my $me = "Andrew" ;
while (<>) {
  # 10:05:15 From Andrew Black : I have done one to my satisfcation...
   if ( /From (.*) : (.*)/) {
     my $name = $1 ;
     my $text = $2 ;
     my $prefix = "# " ; #them
     $prefix = '' if $name =~ /$me/ ;
     say "$prefix$text" ;

   }
}
