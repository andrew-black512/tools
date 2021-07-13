
my %services =(
     s => 'https://www.facebook.com/southwarkcathedral' ,
     sj => 'https://www.youtube.com/channel/UC76aEaiHelFz-F8QAmOS0tw' ,
     ccw => 'https://www.youtube.com/channel/UCfh-pjC5b9PTS-Svf-JIn6w/videos' ,
     ccs => 'https://vimeo.com/stbarnabasdulwich/videos' ,
     roch-off => 'https://www.rochestercathedral.org/worship-online'
  ) ;
my $choice = shift ;
my $chosenservice = $services { $choice } ;
system( "firefox $chosenservice ") ;
