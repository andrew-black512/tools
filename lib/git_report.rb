class GitReport
  attr :gitinfo    # array of 2 stations

  def initialize(  )
    @gitinfo = {}

  end

  def add ( key , value )

    #ToDO += (with nil)
    @gitinfo [ key ] =  value

  end
  def printinfo (type)
    puts type
     puts @gitinfo
  end



end
