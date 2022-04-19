#!/usr/bin/ruby

dirglob = ARGV.shift || '[a-z]*[0-9]*'
#puts "Glob:" + dirglob
dirs = Dir.glob( dirglob )
#



STDERR.puts "Dirs:" + dirs.join(' ')
chosen=dirs.max
STDERR.puts "Chosen:"+chosen
puts chosen  # for CD
