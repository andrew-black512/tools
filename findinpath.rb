#!/usr/bin/ruby
require_relative  'lib/different.rb'
wanted = ARGV.shift
location = ENV['PATH']
wanted_glob = "*#{wanted}*"

dif = Different.new
dif.different '' # force first time

location.split(':').each do |dirname|
   Dir.glob( wanted_glob,  base: dirname).each do |file|
     puts dirname if dif.different dirname
     puts "    #{file}"

   end

end
