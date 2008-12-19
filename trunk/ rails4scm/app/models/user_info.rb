class UserInfo < ActiveRecord::Base
  self.table_name = "operator"
  self.primary_key = "oper_id"
  
  def findOne(operid,pswd)
    begin
      UserInfo.find(:first,:conditions =>["oper_id =? and pswd =?",operid,pswd])
    rescue Exception => e
       print e.backtrace.join("\n")
    end
  end
end
