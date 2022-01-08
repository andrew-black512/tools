#!/usr/bin/perl
# use '5.10.0' ;

foreach my $filename (@ARGV) {
  my $newfilename = $filename ;
  
  # multiple punctuation to one
    $newfilename =~ s/ \s+ ([-]) \s+/$1/gx ;

  # Multiple spaces and ( to _
  $newfilename =~ s/ [\s(]+ /_/gx ;

  # Multiple  ) to nothing
  $newfilename =~ s/  \)+ //gx ;

  print "Rename $filename as  $newfilename\n" ;
  rename $filename , $newfilename or die "Cannot rename file: $!";
}


