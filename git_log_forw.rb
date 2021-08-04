#!/usr/bin/ruby
require 'colorize'
require 'open3'

# Notes
#  deoent play very well with --GRAPH ( \ and / are wribg way)

#---------------------------------------------------------------------
# Semi config
#---------------------------------------------------------------------
def print_indented_text textstring
    indent = '    '
    textarr =  textstring.split "\n"
    textarr = textarr.reverse
    textarr.each do |l|
        # this isn't wroking - colour messes up
        #l.sub!   /(\w{7,}\S*)\s/x , "$1 ___"

        puts "#{indent}#{l}"
    end
end

#---------------------------------------------------------------------


#puts "a".methods

command = 'git log --oneline --decorate'
commandargs = ARGV.join ' '  # remaining args

stdout, stderr, status = Open3.capture3( "#{command} #{commandargs}" )

#QUERY - can status be used?
if stderr == ''

    print_indented_text stdout

else
    puts stderr
end
