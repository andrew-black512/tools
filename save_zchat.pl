#!/usr/bin/perl
#use '5.10.0' ;


=head 1
Format is

'2022-01-06 10.03.37 andrew + Beatrice 2021 78895331242'
Assume date is digits and -
time is digit and .
(might change on upgrade...)
Zoom id is subject to change beyond my control...

=cut

my $selector = 'Black' ;
my $destdir = '/home/andrew/work/meet/notes/' ;

my @dirs = glob ("*$selector*") ;

#print @dirs ;


foreach my $zoom_dir_name (@dirs) {
  my ($date,$time) = $zoom_dir_name   =~ m/(\d+ - \d+ - \d+) \s+ ([\d\.]+)/x ;
  print "$zoom_dir_name\n" ;
  print "$date  $time\n" ;

  my $prefix = "$date_$time_" ;

  exit

  # Multiple spaces and ( to _

  # Multiple  ) to nothing
  $newfilename =~ s/  \)+ //gx ;

  print "Rename $filename as  $newfilename\n" ;
  ##### rename $filename , $newfilename or die "Cannot rename file: $!";
}
