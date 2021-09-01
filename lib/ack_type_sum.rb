#!/usr/bin/ruby
require 'pry'

class AckType
  def self.get_type_array ( directory )
    types_string = `ack -f --show-types #{directory}`
    pp types_string
    (types_string.split"\n" )
     .map{|x| x.split(' => ')}
     .group_by{|y| y[1]}



  end
end

s = AckType.get_type_array ()
binding.pry
