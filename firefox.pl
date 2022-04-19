#!/usr/bin/perl -w

=head1 NAME

xxxxx.pl -

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 TO DO
 integrate with chrome.pl
 allow param to be a domain
 Decide on whether to strip off https://

=cut

use strict ;
use warnings ;
use 5.10.0 ;
use Data::Dumper ;
use File::Spec ;

my %sites = (
  c => 'www.thecalmzone.net/help/webchat/' ,
  cow => 'www.meetup.com/Write-More-Swiss-Cottage-Library-Writing-Group/events' ,
  g => 'www.google.com' ,
  nev =>  'http://www.neverssl.com/' ,  #TODO wont work
) ;
my $verb = shift ;
my $site = $sites {$verb} ;
say "verb=$verb site=$site" ;
die unless $site ;
my $command='firefox -no-remote -P standalone %s' ;

system sprintf $command,$site
