use strict ;
#  TODO
#   reformat mobiles (07xxx xxx xxx)
#   move
#   allow m: h: etc
# Should the reformat be on fly or update file?
# Add header (with ~! )

my $wanted_name = shift ;
use File::Spec ;

my $dir = $ENV { DIST } ;
my $fullfile = File::Spec->catfile ( $dir , 'z_detail/phone'  ) ;

push @ARGV, $fullfile ;
while (<>)
{
  my ($name,$number) = /(.*?) (\d [\d\s]+ \d)/x ;
  next unless /$wanted_name/ix ;
  print ;
  tidy_phone( $number ) ;
}

sub tidy_phone
{
   my $number = shift ;
   # TDOD replaece +44 with 0
   my %formats = (
      '020' => '(\d{4}) (\d{4})'
   ) ;
   my $default_format  = '(\d{3}) (\d{3})' ; # works well with mobiles

   my $found_format ;
   foreach  my $prefix ( keys %formats)
   {
      if ($number =~ /^$prefix/)
      {
         print "found $prefix: $_" ;
         $found_format = $formats { $prefix }   ;
      }
   }

   $found_format ||= $default_format ;
   $number =~ s/$found_format$/ $1 $2/x ;
   print "\n" ;
   print "  > $number \n ";

}
