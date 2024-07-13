#!/usr/bin/ruby
# TODO:  Make filename date dependent.

require "clipboard"
loglocation = '/home/andrew/work/mailwork/collect_lt_202405.txt'

# TODO P1 not part 
email_address =  ARGV.join('') 
Clipboard.copy email_address
puts
puts "Clipboard : #{Clipboard.paste}"
puts

begin
   file=File.open(loglocation, 'a')
   file.printf("%s,\n",  email_address) 
end
