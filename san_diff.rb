#!/usr/bin/ruby

# commit 8e1f5456697f087a45848367bb98d3954910d8bd (HEAD -> dev_0729)
# Author: Andrew Black <andrew@black1.org.uk>


def git_date2txt( datestring)
  # Date:   Mon Aug 2 14:39:56 2021 +0100
  # assume we dont care about seconds, tz or year most of time.
  wd,month,day,time,year = datestring.split
  return sprintf "%3s-%02s", month, day
end
def process_diff ( line )


  case line
  when /^commit\s+(.*)/
    puts "Commit   #{$1}"
  when /^Author:\s+(.*)/
    puts "   #{$1}"
  when /^Date:  \s+(.*)/
    datestring = git_date2txt $1
    puts "   #{datestring}"

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
