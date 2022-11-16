#!/usr/bin/ruby
# TODO:  Ouput to a well known file 
require "clipboard"

password = ARGV.last 
fileoutput = ARGV.join(' ') 
Clipboard.copy password
puts "Clipboard : #{Clipboard.paste}"
