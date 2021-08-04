#!/usr/bin/ruby

# commit 8e1f5456697f087a45848367bb98d3954910d8bd (HEAD -> dev_0729)
# Author: Andrew Black <andrew@black1.org.uk>


def git_date2txt( datestring)
  # Date:   Mon Aug 2 14:39:56 2021 +0100
  # assume we dont care about seconds, tz or year most of time.
  wd,month,day,time,year = datestring.split
  return sprintf "%02d-%3s %s", day, month, time[0,5]
end
def process_diff ( line )


  case line
  when /^commit\s+(.*)/
    puts ''
    puts "Commit   #{$1}"
  when /^Author:\s+(.*)/
    # At moment this is only me so boring.
    #puts "   #{$1}"
  when /^Date:  \s+(.*)/
    datestring = git_date2txt $1
    puts "   #{datestring}"

    when /^\+{3} b\/([.\w]+)/
      file = $1
      puts "   #{file}"
    when /^\+/
      puts "     #{line}"
    when /^\s+(.+)/
      # TODO: only first (or chunk of) lines. Wait for refactor-ish
      # context lines coming out as log
      logline = $1
      puts "     #{logline}"
  end

end
combined_argv=ARGV.join '-'
indent = '    '



#TODO - end/ change of file
ARGF.each do |line|
    process_diff line

end
