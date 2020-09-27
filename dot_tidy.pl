#!/usr/bin/perl
use strict ;
use 5.10.0 ;
=head1

rag bag of changes to dot files.
Some act on "hints" in the file.

=cut

say "hello" ;
while (<>) {
  # captital word before quotes
  #  ABC"text in quotes" extracts text as a node
  if ( / ([A-Z]+) ( " [^"]+ " ) /x) {
    my $name = $1 ;
    my $text = $2 ; ## or maybe inc quotes
    say "Found $name $text"
  }

}
