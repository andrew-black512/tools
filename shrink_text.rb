#!/usr/bin/ruby


#TDO t.sub /(\w)\b/ ,'_'
#t.sub! /(\w)\b/ ,'_'

text = ARGV 
puts text.count 
while text.count > 0
  puts text.join " "
  puts 
  sleep 0.5 * rand + 0.3
  size=text.count
  text.delete_at rand size 

end
