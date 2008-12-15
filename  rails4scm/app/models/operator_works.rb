class OperatorWorks < ActiveRecord::Base
  self.table_name = "operator_works"
  
  def findOperatorWorksUserId(operid)
    sql = "select PERSON_CLASS_CODE from operator_works where oper_id='" + operid + "'"
    OperatorWorks.find_by_sql(sql) 
  end
end
