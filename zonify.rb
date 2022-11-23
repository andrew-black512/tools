#!/usr/bin/ruby

def createdir (dirname)
end

fileglob = '*.rb'  # ARGV.shift
Dir.glob(fileglob).each do |filename|
   puts filename
   f=File.new filename
   puts f.mtime
end
