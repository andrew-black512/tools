#!/usr/bin/ruby
# TODO - handle no arguent case more clearly
 
dirglob = ARGV[0] + '*' 
lastd = Dir.glob(dirglob) 
  .sort.last 
puts lastd
