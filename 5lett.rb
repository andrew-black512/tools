#!/usr/bin/ruby
def print_comm wa
  puts wa.shuffle.join " "

end


word_array = ARGV.shift.chars
print_comm word_array
