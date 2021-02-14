
my %services =(
     s => 'https://www.facebook.com/southwarkcathedral' ,
  ) ;
my $choice = shift ;
my $chosenservice = $services { $choice } ;
system( "firefox $chosenservice ") ;
