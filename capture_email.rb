#!/usr/bin/ruby
# TODO:  Make filename date dependent.

require "clipboard"
loglocation = '/home/andrew/work/mailwork/collect_lt_202405.txt'

# TODO P1 not part 
password =  ARGV.join('') 
Clipboard.copy password
puts
puts "Clipboard : #{Clipboard.paste}"
puts

begin
   file=File.open(loglocation, 'a')
   file.printf("%s,\n",  password) 
end
