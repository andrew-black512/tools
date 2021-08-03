#!/usr/bin/ruby

## quick demo of how ARGF ( perl <> ) works
combined_argv=ARGV.join '-'
pp ARGV
puts "ARGV=#{ combined_argv } "
indent = '    '



#TODO - end/ change of file
ARGF.each do |line|
    puts "#{indent}#{line}"

end