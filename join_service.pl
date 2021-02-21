
my %services =(
     s => 'https://www.facebook.com/southwarkcathedral' ,
     sj => 'https://www.youtube.com/channel/UC76aEaiHelFz-F8QAmOS0tw' ,
     cc => 'https://www.youtube.com/channel/UCfh-pjC5b9PTS-Svf-JIn6w/videos' ,
  ) ;
my $choice = shift ;
my $chosenservice = $services { $choice } ;
system( "firefox $chosenservice ") ;
