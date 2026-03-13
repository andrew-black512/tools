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

my %sites = (
  fg => 'www.flickr.com/groups/plot94/' ,
  fr => 'www.flickr.com/cameraroll/' ,
  g => 'www.google.com' ,
  gmx => 'gmx.co.uk' ,
  c => 'www.thecalmzone.net/help/webchat/' ,
  ch => 'mail.google.com/chat/u/0/#chat/dm/tAjbzgAAAAE' ,
  l  => 'docs.google.com/spreadsheets/d/1lVMNAgCsiAaKcMG3sTG-d4XHi_Fod97I0IhqLxz7ssY' ,
  lil => 'docs.google.com/document/d/1o3-SYpuXJwNWHiOtHRmSy8J37mW_2bO6_Dsxl6BpVac/edit#', #lily ref
  m => 'mail.google.com/mail/u/0/#label/512Blank' ,
  nerd => 'quad.nerdlegame.com/game',
  rec => 'drive.google.com/drive/folders/0BybtFQ3kyI3RZl9DenRjSDFLTVU' ,
  ph => 'docs.google.com/document/d/192faOiM0Zso9LxjvT0CeZnC0FyUrXbwjVk0IqKahZ-o' ,
  track => 'drive.google.com/drive/folders/1ofvnef_DgEeNbXM9hlih2btEPENrTN54' ,
) ;
my $verb = shift ;
my $site = $sites {$verb} ;

unless ($site) {
  print "keys are \n   " ;
  say join "  ", sort keys(%sites) ; 
  exit ;
}
say "verb=$verb site=$site" ;
die unless $site ;


my $command='google-chrome --app=https://%s' ;
if ($site =~ /folders|flickr/) {
  # folders in drive are better in a window with tabs.
  $command='google-chrome %s' ;

}
say $command ;
system sprintf $command,$site
