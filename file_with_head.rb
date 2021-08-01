#!/usr/bin/ruby
require 'colorize'
require 'open3'
#https://www.honeybadger.io/blog/capturing-stdout-stderr-from-shell-commands-via-ruby/

#---------------------------------------------------------------------
# Semi config
#---------------------------------------------------------------------
def print_indented_text textstring
    indent = '    '
    textarr =  textstring.split "\n"
    textarr = textarr.reverse
    textarr.each do |l|
        l.sub! /\s/, '     '
        puts "#{indent}#{l}"
    end
end

#---------------------------------------------------------------------


#puts "a".methods

filename = ARGV.shift
command = ARGV.join ' '  # remaining args
puts filename.light_green.bold
puts command.blue

stdout, stderr, status = Open3.capture3( command )

#QUERY - can status be used?
if stderr == ''

    print_indented_text stdout

else
    puts stderr
end
