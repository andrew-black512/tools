#!/usr/bin/ruby
require 'fileutils'

def createdir (dirname)
    #
    if ! Dir.exist?(dirname)
       puts "create #{dirname}"
      Dir.mkdir(dirname) 
    end

end



fileglob = ARGV.shift
format = '%Y_%m'
Dir.glob(fileglob).each do |filename|
   puts filename
   f=File.new filename
   dirname = f.mtime.strftime( format )  # _%d configurable?s
   createdir dirname

   puts "  Move #{filename} to #{dirname}" 
   FileUtils.mv( filename, dirname + '/' ) 
end
