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
  g => 'www.google.com' ,
  c => 'www.thecalmzone.net/help/webchat/' ,
  ch => 'mail.google.com/chat/u/0/#chat/dm/tAjbzgAAAAE' ,
  m => 'mail.google.com/mail/u/0/#label/512Blank' ,
  rec => 'drive.google.com/drive/folders/0BybtFQ3kyI3RZl9DenRjSDFLTVU' ,
  ph => 'docs.google.com/document/d/192faOiM0Zso9LxjvT0CeZnC0FyUrXbwjVk0IqKahZ-o' ,
) ;
my $verb = shift ;
my $site = $sites {$verb} ;
say "verb=$verb site=$site" ;
die unless $site ;

my $command='chromium-browser --app=https://%s' ;
if ($site =~ /folders/) {
  # folders in drive are better in a window with tabs.
  $command='chromium-browser %s' ;

}
say $command ;
system sprintf $command,$site
