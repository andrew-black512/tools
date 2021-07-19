#!/usr/bin/ruby

fileglob = ARGV.shift
partlist = []
Dir.glob(fileglob).each do |file|
   puts file
    #TODO \" isnt getting throuhg. Not needed at moment
    partfile = "#{file}_part"
    system "pdfseparate -l 1 #{file}  #{partfile}  "
    partlist.push partfile
end
puts partlist.join ' '
