# 
# To change this template, choose Tools | Templates
# and open the template in the editor.
 

class Util
  def initialize
    
  end
  
  def formatDatatimeToSting(datatime)
    if datatime== nil || datatime== "" then
      return ""
    end
    fmt = '%Y-%m-%d'
    
    cl = datatime.class.to_s
    if cl =="Time" then
      return datatime.strftime(fmt)
    else
      data = ParseDate.parsedate(datatime,fmt)
      d = Time.local( data[0],data[1],data[2] )
      return d.strftime(fmt)
    end
  end
  
  def intercept(str,startsize,endsize)
    if(str != nil) 
      if(startsize == nil) 
        startsize = 0
      end
      startsize = startsize + 2
      if(endsize == nil)
        endsize = str.length
      end
      endsize = endsize *2 + 2
      lstr = Iconv.conv("UTF-16","gb2312",str)
      str = Iconv.conv("gb2312","UTF-16",lstr[startsize,endsize]) 
      if(lstr.length>endsize)
        str << " ..."
      end
    end
    return str
  end
  
end
