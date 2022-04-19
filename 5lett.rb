#!/usr/bin/ruby

def del_random arr
  newarr = arr.clone

  newarr.delete_at rand( arr.count )
  return newarr
end
def print_comm wa
  wa_reduced = del_random wa
  puts wa_reduced.shuffle.join " "

end


word_array = ARGV.shift.chars

while true do
  print_comm word_array
  puts ''
  sleep 1
end
