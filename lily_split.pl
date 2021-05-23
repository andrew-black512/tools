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

my $note = qr/[a-g]rR/ ; # TODO others
my $noteadd = qr/ ([ei]s)? [',']* /x ;
while (<>) {
  s/ $note / | /g ;
  # body...
}
