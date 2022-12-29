#!/usr/bin/perl -w

=head1 NAME

**file - **desc

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 TO DO

=cut

use strict ;
use warnings ;
use feature ":5.10" ;
use Data::Dumper ;

#--------
my $lastline ;
sub merge_in {
    my $fh=shift ;
    my $time=shift ;
    say "Merge in $time" ;
    $lastline = <$fh> unless $lastline ;
    #say $lastline ;
    while(  $lastline lt $time )
    {
        print $lastline  ;
        $lastline = <$fh>
    }
}
#--------
my $merge_file = shift ;  # ARG1 
open(my $FH, "<", $merge_file)
                    or die "Can't open '$merge_file' : $!" ;


my %prefix = (
   1 => '# '    ,       # Them
  -1 => '     ' ,       # Me
) ;

say "Calm output" ;
my $direction = 0 ; # initially don't print
while (<>) {
    #These affect following line
    if (/^CALM Helpline$/ || /helpline member/)  {
       $direction = 1 ;
       #print Dumper $direction ;
       next ;
    }
    next if /^$/ ;
    if (/^ ( \d\d:\d\d ) /x ) {
        merge_in $FH, $1 ;
        next ;
    }
    s/'/''/g ;  # apostrophes mess up the colouring (bodge)

    # I rarely use WE or YOU but they do...
    #  (workround if the "calm Helpline text isnt present")
    if ( /\bwe\b/ix || /\b you r? \b/ix ) {
      # $direction = 1 ;
    }

    if ($direction) {
      print $prefix{ $direction } . $_ ;
      $direction = -1 ;
    }

}
