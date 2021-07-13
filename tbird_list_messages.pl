#!/usr/bin/perl -w

=head1 NAME

tbird.pl - list Thunderbird drafts

=head1 SYNOPSIS

Lists messages in specific thunderbird folders.
Has to be in the top dir profile

TODO - make dir configurable

=head1 DESCRIPTION

=head1 TO DO

=cut

use strict ;
use warnings ;
use 5.10.0 ;
use Data::Dumper ;
use File::Spec ;

my $tbird_local_dir = 'Mail/Local Folders' ; #TODO best was to set this
# Additonal cases inlcude
#     ImapMail/mail.aa.net.uk
#     ImapMail/imap.gmail.com
#       Drafts-1 (drafts on the server)

my @folders =  (
    #'Drafts-1' ,
    'Unsent Messages' ,     # Outbox
    'Drafts-ab 512'   ,
    ) ;

say '' ;

foreach my $folder ( @folders ) {
   say $folder ;
   my $filename = File::Spec->catfile ( $tbird_local_dir , $folder  ) ;
   open my $F, '<', $filename or  die "Can't find $filename" ;
   while (<$F>) {
       #start of new message. TODO print a line per message
       # This is a From seperator, not a header with :
       say '' if /^From[^:]/ ;

       # To: comes first so indent subject more for clarity
       print "   $_"  if /To:/ ;
       print "     $_"  if /Subject:/ ;
   }
   say '' ;
}
