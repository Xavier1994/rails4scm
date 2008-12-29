class OperatorWorks < ActiveRecord::Base
  self.table_name = "operator_works"
  
  def findOperatorWorksUserId(operid)
    sql = "select PERSON_CLASS_CODE from operator_works where oper_id='" + operid + "'"
    OperatorWorks.find_by_sql(sql) 
  end
  
  #查找用户是否有执行事件的权限[已创建、待评估、决策中、变更中、关闭]
  def quarters_validate(oper_id,quarters_id)
    data = OperatorWorks.find(:all,:conditions =>["oper_id =? and person_class_code =?",oper_id,quarters_id])
    if(data.size>0) then
      return 100
    else
      return -1
    end
  end
end
