#!/usr/bin/perl -w

=head1 NAME

xxxxx.pl -

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 TO DO

=head1 Format notes
Format is

'2022-01-06 10.03.37 andrew + Beatrice 2021 78895331242'
Assume date is digits and -
time is digit and .
(Format might change on upgrade...)
Zoom id is subject to change beyond my control...

=cut

use strict ;
use warnings ;
use 5.10.0 ;
use Data::Dumper ;
use File::Spec ;
use Cwd ;

#-----------------------------------------------------

sub rename_files {
  my $dir = shift ;
  my $prefix = shift ;
  my $dest = shift ;

  my $dry = 0 ;

  my $savedir = getcwd;

  chdir $dir or die "can't change $!";

  my @files = glob "*" ;

  foreach my $file (@files) {
    my $newfilename = "$dest/$prefix$file" ;
    $newfilename =~ s/meeting_saved_// ;
    print "   Rename $file as  $newfilename\n" ;
    rename $file , $newfilename or die "Cannot rename file: $!" unless $dry ;


  }
  chdir $savedir ;
  rmdir $dir or die "can't rmdir: $!" ;
  say '' ;
}
#-----------------------------------------------------

my $selector = 'Black' ;
my $destdir = '/home/andrew/work/meet/notes/' ;
my $destdirleaf = lc $selector ;

my @dirs = glob ("*$selector*") ;

#print @dirs ;


foreach my $zoom_dir_name (@dirs) {
  my ($date,$time) = $zoom_dir_name   =~ m/(\d+ - \d+ - \d+) \s+ ([\d\.]+)/x ;
  print "== $zoom_dir_name\n" ;

  # sanatise date and time (only one type of seperator)
  $date =~ s/^20// ;   # not year 2100 compliant !
  $time =~ s/\.//g ;
  my $prefix = sprintf "%s-%s-", $date , $time ;
  ##print "$prefix\n" ;
  ##print "$date  $time $prefix a\n" ;

  rename_files ($zoom_dir_name, $prefix,
     "/home/andrew/work/meet/notes/$destdirleaf"
  ) ;

}
