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

my %sites = {
  g => 'www.google.com' ,
} ;
my $verb = shift ;
my $site = $sites {$verb} ;
system "chromium-browser --app=https://$site"
