class GitReport
  attr :gitinfo    # array of 2 stations

  def initialize(  )
    reinit

  end

  def add ( key , value )
    @gitinfo [ key ] =  value
  end
  def addmulti ( key , value )
    @gitinfo[key].push   value
  end
  def reinit
    @gitinfo = { 'file' => []}

  end

  def printinfo (type)
    if @gitinfo['date']
      pp @gitinfo
      files = @gitinfo['file'].join ','
      puts files
      puts sprintf '%-10s  %-20s  "%20s"', @gitinfo['date'].upcase , files.upcase, @gitinfo['log']
    end
    reinit
  end



end
