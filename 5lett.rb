#!/usr/bin/ruby

def del_random arr
  arr.delete_at rand( arr.count )
  return arr
end
def print_comm wa
  wa_reduced = del_random wa
  puts wa_reduced.shuffle.join " "

end


word_array = ARGV.shift.chars

while true do
  print_comm word_array
  sleep 0.5
end
