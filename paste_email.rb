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

   opts.on("-f","--comment COMMENT","Give comment" ) do |comment|
     puts "Given comment"
     options[:comment]=comment
   end

   opts.on("-d","--domain ","Give email domain" ) do |d|
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
   comment=File.open(loglocation, 'a')
   comment.printf("%s,%s\n",  email_address,options[:comment]) 
end


