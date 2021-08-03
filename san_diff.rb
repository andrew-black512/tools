#!/usr/bin/ruby


def process_diff ( line )
  puts file
  case line
  when /^\+{3} b\/([.\w]+)/
      file = $1
      puts "  File #{file}"
    when /^\+/
      puts "     #{line}"
  end

end
combined_argv=ARGV.join '-'
indent = '    '



#TODO - end/ change of file
ARGF.each do |line|
    process_diff line

end
