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

push @ARGV,'/home/andrew/.thunderbird/98eg4dmp.default/ImapMail/mail.aa.net.uk/msgFilterRules.dat' ;
my $diag = 0 ; # make configurable if needed
my $version = <> ;
my $loging = <> ;

my %rule ;
while (<>) {
  my ($verb,$value) = split /=/ ;
  $value =~ s/"//g ;
  say "$verb , $value " if $diag  ;
  if ($verb eq 'name') {  # starts a new rule
    say ;
    say "# $value" ; # name as a markdown title
  } elsif ($verb eq 'action') {
    $rule{'action'} = $value ;
  } elsif ($verb eq 'actionValue') {
    $rule{'actionValue'} = $value ;
    print_action(\%rule) ;
  } else {
    print "    $_" ;
  }

}

sub print_action  {
  my $rule = shift ;
  #say Dumper \$rule ;
  say $$rule {'action'} ;
}
