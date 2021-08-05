#!/usr/bin/ruby

reg = /-(\w+)/

ARGF.each    do |l|
  if l.match(reg)
    printf "%-10s,%s", $1, l
  end
  puts l
end
