#!/usr/bin/ruby
require 'pry'

class AckType
  def self.get_type_array ( directory )
    # ack -f --show-types returns lines
    #    filename => type
    types_string = `ack -f --show-types #{directory}`
    #pp types_string
    (types_string.split"\n" )
     .map{|x| x.split(' => ')}
     .group_by{|y| y[1]}



  end
  def self.print_type_counts ( typearray )
    typearray.each do |t,keyarr|
      printf "                 %-10s %d\n", t, keyarr.count
    end
  end
end

# call from pry
def t dir
  #dir = ARGV.shift
  type_hash = AckType.get_type_array ( dir)
  t = AckType.print_type_counts type_hash
  #binding.pry
  return 1
end
