# 
# To change this template, choose Tools | Templates
# and open the template in the editor.
 

class Util
  def initialize
    
  end
  
  def formatDatatimeToSting(datatime)
    if datatime== nil then
      return ""
    end
    fmt = '%Y-%m-%d'
    if datatime.isdst then
      return datatime.strftime(fmt)
    else
      return datatime.to_datetime.strftime(fmt)
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
    end
    return str
  end
  
end
