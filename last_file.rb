#!/usr/bin/ruby

dirglob = ARGV.shift || '[a-z]*[0-9]'
#puts "Glob:" + dirglob
dirs = Dir.glob( dirglob ).sort
#puts "Dirs:" + dirs.join(' ')
puts dirs.last  # for CD
