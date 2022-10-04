#!/usr/bin/ruby


file = ARGV.shift
start_page = ARGV.shift.to_i
finish_page = ARGV.shift.to_i
## TODO: check arg (raise error)
chuncks = 10   ## TODO: or param

range = (start_page .. finish_page) #.step(chuncks)
puts range
puts start_page
puts range.first
puts range.last
range.each do |s|
  puts "s"
end
