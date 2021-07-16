#!/usr/bin/ruby

#---------------------------------------------------------------------
#potential lib
class Array
  def comma_join  #( arr )
    self.join(',')
  end
  def expandf (format)
    self.map { |s|
      sprintf( format, s)
    }.join
  end
end

def comma_join_test
  puts ['a'].comma_join
  puts (%w/a b c/ ).comma_join
  puts [].comma_join

end
def expandf_test
  #puts ['a'].comma_join
  puts ([1 , 2 ,10] ).expandf ("p%02d ")
  #puts [].comma_join

end
#---------------------------------------------------------------------
#potential lib - mysys
def mysys ( s )
  puts "SYS: #{s}"
  system s
end
#---------------------------------------------------------------------
class PageRange
  attr :range
  attr :format

  def initialize( s, e )
    @start_page = s
    @range = (s..e)
    @format='p%02d '
  end

  def print_odd_pages
    raa = @range.step(2).to_a
    pp raa.expandf( @format )
  end
  def print_even_pages
    # This runs backward F .. S+1 (but ruby doesnt let you do that)
    new_start = self.start_page + 1
    pp new_start
    raa = (new_start .. self.finish_page ).step(2).to_a
    pp raa.reverse.expandf( @format )
  end
  # these maybe useful, but more to demonstarte how to get the bounds of the range
  def start_page
    @range.first
  end
  def finish_page
    @range.last
  end
  def extract
    "-f #{start_page} -l #{finish_page} "
  end
end

class TestPageRange
  def initialize
    pr = PageRange.new( 1,10 )
    puts "start " + pr.start_page.to_s
    puts "end " + pr.finish_page.to_s
    puts pr.print_odd_pages
    pr.print_even_pages

  end
end
#---------------------------------------------------------------------

# Main
# get args

file = ARGV.shift
start_page = ARGV.shift.to_i
finish_page = ARGV.shift.to_i
## TODO: check arg (raise error)
puts "#{start_page} #{finish_page} "

#comma_join_test
mysys "rm p* -v"
mysys "rm b.pdf"
mysys "rm b.pdf"

r = PageRange.new( start_page , finish_page )
format='p%02d '
mysys "pdfseparate #{r.extract} #{file} #{format}"
mysys " pdfunite #{r.print_odd_pages} a.pdf"
mysys " pdfunite #{r.print_even_pages} b.pdf"
mysys 'ls -lrt'
mysys 'gnome-open a.pdf'
mysys 'gnome-open b.pdf'
