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
  rec => 'drive.google.com/drive/folders/0BybtFQ3kyI3RZl9DenRjSDFLTVU' ,
  ph => 'docs.google.com/document/d/192faOiM0Zso9LxjvT0CeZnC0FyUrXbwjVk0IqKahZ-o' ,
) ;
my $verb = shift ;
my $site = $sites {$verb} ;
say "verb=$verb site=$site" ;
die unless $site ;

system "chromium-browser --app=https://$site"
