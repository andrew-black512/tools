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

aim
 - change ' to |       ******
 - get ' in words into hyphens
- count nmber of bars

Done
 - starts quartes on new line \: -> nl


=cut

print "test \xB7\n" ;


#config
    # serves 2 purposes - mimics the verse number and indents to 2nd and 4th quarter
    my $quarter_prefix = "\t\t" ;
    my $apost_reg = qr/[=]/ ;
while (<> )
{
        # TODO - add extra cases in correct order. Spacing " | " is a bodge!
	s/ \s* $apost_reg \s* / | /xg ;
  s/ (\d+) /$1\t/x ; #TODO match with $quarter_prefix
	###s/:\s*/:\n$quarter_prefix/x ;
  s/\s* \# \s*/ · /xg ;

	print $_ ;
}
