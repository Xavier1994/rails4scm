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
end