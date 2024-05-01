#!/usr/bin/ruby
if ARGV.count < 3
  puts <<EOS

  print_pages_gen  file  start end
  doesnt read file 
  Outputs a list of chunks

EOS
   exit
end 

file = ARGV.shift
start_page = ARGV.shift.to_i
finish_page = ARGV.shift.to_i
## TODO: check arg (raise error)
chuncks = 10   ## TODO: or param
prog = 'print_pages.rb'

range = (start_page .. finish_page)
range.step(chuncks).each do |st|
  actual_last = [ st+chuncks - 1, finish_page ] .min  
  puts "# #{prog} #{file} #{st} #{actual_last} "
  #put "pause" TODO wrong verb
end
