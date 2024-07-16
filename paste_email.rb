#!/usr/bin/ruby
# TODO:  Make filename date dependent.

require "clipboard"
loglocation = '/home/andrew/work/mailwork/trans_emails.txt'

# TODO P1 not part 
base = '@andrew.black1.org.uk'
email_address =  ARGV.join('') + base
Clipboard.copy email_address
puts
puts "Clipboard : #{Clipboard.paste}"
puts

begin
   file=File.open(loglocation, 'a')
   file.printf("%s,\n",  email_address) 
end
