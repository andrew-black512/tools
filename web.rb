#!/usr/bin/ruby
require 'csv'

datafile = ARGV[0]
CSV.foreach(  datafile, headers:true ) do |row|
   #pp row
   # row is array of fields
       station = row[1]
       puts station
end
