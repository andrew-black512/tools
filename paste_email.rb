#!/usr/bin/ruby

require 'optparse'
require 'pp'
require "clipboard"
loglocation = '/home/andrew/work/mailwork/trans_emails.txt'


#---------------------------------------------------------------------------
options = {
    :domain => 'andrew.black1.org.uk',
    :comment => '' ,
}
OptionParser.new do |opts|
   opts.banner = "Usage: paste_email.rb  email with space .... "

   opts.on("-f","--file FILE","Give filenameTODO" ) do |file|
     puts "Given file"
     options[:file]=file
   end

   opts.on("-r", "--reverse", "Reverse direction") do |v|
       options[:reverse] = v
   end
   opts.on("-d","--domain ","Give email domain" ) do |d|
      puts "Given file"
      options[:domain]=d
   end


   opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
       options[:verbose] = v
   end
   opts.environment
end.parse!

puts "xx  "
pp options if options[:verbose]
#helpandexit if ARGV.count == 0

base = '@' +  options[:domain]
email_address =  ARGV.join('') + base
Clipboard.copy email_address
puts
puts "Clipboard : #{Clipboard.paste}"
puts

begin
   file=File.open(loglocation, 'a')
   file.printf("%s,\n",  email_address) 
end


