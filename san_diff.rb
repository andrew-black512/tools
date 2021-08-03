#!/usr/bin/ruby


def process_diff ( line )

  case line
    when /^\+/
      puts "  add #{line}"
  end

end
combined_argv=ARGV.join '-'
indent = '    '



#TODO - end/ change of file
ARGF.each do |line|
    process_diff line

end
