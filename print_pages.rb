#!/usr/bin/ruby

#---------------------------------------------------------------------
#potential lib
class Array
  def comma_join  #( arr )
    self.join(',')
  end
end
def comma_join_test
  puts ['a'].comma_join
  puts (%w/a b c/ ).comma_join
  puts [].comma_join

end

#---------------------------------------------------------------------

start_page = ARGV.shift
finish_page = ARGV.shift
## TODO: check arg (raise error)
puts "#{start_page} #{finish_page} "

#comma_join_test
