#!/usr/bin/ruby

require 'optparse'
require 'pp'


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

pp options if options[:verbose]
#helpandexit if ARGV.count == 0


begin
  # work here
rescue Interrupt  => e
  puts ''
end

