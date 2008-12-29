class Argument < ActiveRecord::Base
  self.table_name = "Argument"
  self.primary_key = "CODE"
  
  def event_max_id(num,code)
       arguments = Argument.find_by_sql("select * from Argument where code='" + code + "'")
       if num == nil then
         num = 1
       end
       idY = arguments[0].VALUE.to_i
       idS  = idY + num
       first = arguments[0]
       first.VALUE=idS.to_s
       first.save
       idYq = idY + 1
       idYj = idY + num
       resourArray = Array.new(num*2)
       j = 0
       t = num
       for i in (idYq..idYj)
         k = i.to_s
         sid = ""
         case k.size
           when 1
              sid = "E00000000" + k
           when 2
              sid = "E0000000" + k  
           when 3
              sid = "E000000" + k
           when 4
              sid = "E00000" + k
           when 5
              sid = "E0000" + k
           when 6
              sid = "E000" + k
           when 7
              sid = "E00" + k
           when 8
              sid = "E0" + k
           when 9
              sid = "E" + k
         end
         resourArray[j] = sid
         resourArray[t] = idY + (j+1)
         j = j + 1
         t = t + 1
       end
       
    return resourArray
  end
  
  def max_id(num,code)
       arguments = Argument.find_by_sql("select * from Argument where code='" + code + "'")
       if num == nil then
         num = 1
       end
       idY = arguments[0].VALUE.to_i
       idS  = idY + num
       first = arguments[0]
       first.VALUE=idS.to_s
       first.save
       
       idYq = idY + 1
       idYj = idY + num
       resourArray = Array.new(num)
       j = 0
       for i in (idYq..idYj)
         resourArray[j] = i.to_a
         j = j + 1
       end
       return resourArray
  end
end
