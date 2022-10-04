#!/usr/bin/ruby


file = ARGV.shift
start_page = ARGV.shift.to_i
finish_page = ARGV.shift.to_i
## TODO: check arg (raise error)
chuncks = 10   ## TODO: or param

range = (start_page .. finish_page)
puts range
puts start_page
puts range.first
puts range.last
range.step(chuncks).each do |st|
  actual_last = st+chuncks - 1  #TODO max
  puts "pp #{file} #{st} #{actual_last} $"
end
