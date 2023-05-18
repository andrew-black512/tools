#!/usr/bin/ruby
# TODO:  Ouput to a well known file 
require "clipboard"

# TODO P1 not part 
password =  ARGV.join('') 
Clipboard.copy password
puts "Clipboard : #{Clipboard.paste}"
