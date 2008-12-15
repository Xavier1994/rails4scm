class PersonClass < ActiveRecord::Base
  self.table_name = "person_class"
  self.primary_key = "person_class_code"
  
  def findPersonClass_UserId(operid)
    PersonClass.find(:all,:conditions =>["oper_id =?",operid])
  end
end
