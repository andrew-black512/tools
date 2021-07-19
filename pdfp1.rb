#!/usr/bin/ruby

def pdf_pages (file)
   system "pdfinfo  #{file} | grep Pages  "
end
## TODO: - make the output file automaticella (eg as far as the *)
exit if ARGV.count < 2

fileglob = ARGV.shift
outfile = ARGV.shift

partlist = []
Dir.glob(fileglob).each do |file|
   puts file
    #TODO \" isnt getting throuhg. Not needed at moment
    partfile = "#{file}_part"
    system "pdfinfo  #{partfile} | grep Pages  "
    system "pdfseparate -l 1 #{file}  #{partfile}  "

    partlist.push partfile
end
puts ''
puts partlist.join ' '
system "pdfunite   #{partlist.join ' '}  #{outfile} "
pdf_pages outfile
