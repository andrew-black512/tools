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
class PageRange
  attr :range

  def initialize( s, e )
    @start_page = s
    @range = (s..e)
  end

  def print_odd_pages
    raa = @range.step(2).to_a
    pp raa.comma_join
  end
  def print_even_pages
    puts "# TODO: reverse"
    puts "# TODO: split into chunks"
    new_start = self.start_page + 1
    pp new_start
    raa = (new_start .. self.finish_page ).step(2).to_a
    pp raa.comma_join
  end
  # these maybe useful, but more to demonstarte how to get the bounds of the range
  def start_page
    @range.first
  end
  def finish_page
    @range.last
  end
end

class TestPageRange
  def initialize
    pr = PageRange.new( 1,10 )
    puts "start " + pr.start_page.to_s
    puts "end " + pr.finish_page.to_s
    pr.print_odd_pages
    pr.print_even_pages

  end
end
#---------------------------------------------------------------------

# Main
# get args
start_page = ARGV.shift
finish_page = ARGV.shift
## TODO: check arg (raise error)
puts "#{start_page} #{finish_page} "

#comma_join_test
TestPageRange.new
