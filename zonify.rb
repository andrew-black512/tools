#!/usr/bin/ruby

fileglob = ARGV.shift
Dir.glob(fileglob).each do |filename|
   puts filename
end
