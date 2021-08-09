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
    if @gitinfo != {}
       puts sprintf '%-10s  %-20s  "%20s"', @gitinfo['date'].upcase , @gitinfo['file'].upcase, @gitinfo['log']
    end
    @gitinfo = {}
  end



end
