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


=head1

It has two functions
        - dowmloaded from CoE BCP and | added
        - sent by choir amd wi;; jave assortmemt of '| etc
       (maybe  need to separate  these)
       
aim
 - change ' to |       ******
 - get ' in words into hyphens
 - count number of bars

Done
 - starts quartes on new line \: -> nl


=cut

#config
    # serves 2 purposes - mimics the verse number and indents to 2nd and 4th quarter
    my $quarter_prefix = "\t\t" ;

    #TODO name sillly
    my $apostrophe_reg = qr/[=|]/ ;
while (<> )
{
        # TODO - add extra cases in correct order. Spacing " | " is a bodge!
  #barline within word
  s/  (?<=\w)  $apostrophe_reg (?=\w) /-|/xg ;
  s/ \s* $apostrophe_reg \s* / | /xg ;
  s/ (\d+) /$1\t/x ; #TODO match with $quarter_prefix
  ### TODO is split on ":" a different program
  s/(?<=[\S] ) \s* :\s*/:\n$quarter_prefix/x ;  #TODO only if tx

  # centre dot
  s/\s* \# \s*/ · /xg ;
  s/\s+ \. \s+/ · /xg ;  # ord dot spaced both sides

  # ignored commas
  s/ \s* ,_ \s* / /xg ;


	print $_ ;
}
