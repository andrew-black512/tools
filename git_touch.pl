#!/usr/bin/perl -w
#--------------------------------------------------

=head1 NAME

git_touch - creates a test edit to a file and commits into git

=head1 SYNOPSIS

  git_touch  [file=f] [comment inc spaces]]

=head1 DESCRIPTION

defaults to test.txt if no file given.

Used for automating demos etc

=head1 TO DO

=cut

use strict ;
use warnings ;
use feature ":5.10" ;
use File::Slurp ;
use POSIX qw/strftime/ ;

use Getopt::Long ;
use Pod::Usage;
use Data::Dumper ;

my %command_options ;

# see getoptlong_template_test.pl for more examples.

# Get the command optopns and warn user if they don't match
my $parse_result =  GetOptions (  \%command_options ,
       'file=s' ,        # file to touch
       'commit!' ,
       "man", 'help',    # standard otptions
        ) ;

pod2usage (2) unless $parse_result ;
pod2usage (1) if $command_options{ help }  ;
pod2usage (2) if $command_options{ man }  ;

my $file = $command_options{ file } // 'test.txt' ;
my $comment = join( ' ',@ARGV) || 'A change' ;
my $time =  strftime ( "%a %d-%b %H:%M:%S",  localtime() ); ;
my $comment_detailed = "$comment - $time" ;

write_file( $file , {append => 1 }, "$comment_detailed\n"   ) ;
system "tail $file " ;

git_commit ( $comment_detailed, $file ) ;

#-------------------------------------------------------------------------------------
sub git_commit {
    my $message = shift ;
    my $file_etc = shift // '' ;
    
system ( "git commit $file_etc -m \"$message\" " ) ;

}
