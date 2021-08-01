#!/usr/bin/ruby
require 'colorize'
require 'open3'
#https://www.honeybadger.io/blog/capturing-stdout-stderr-from-shell-commands-via-ruby/

#puts "a".methods

filename = ARGV.shift
command = ARGV.join ' '  # remaining args
puts filename.light_green.bold
puts command.blue

stdout, stderr, status = Open3.capture3( command )
puts stdout
