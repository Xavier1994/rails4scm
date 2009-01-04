class Param < ActiveRecord::Base
  self.table_name = "param"
  self.primary_key = "id"
  
 #树型的大类[配置项分类顶级]一级
 def findParamAll()
        sql = "select distinct(param_code) con_type from param where param_class='con_type'"
        
        Param.find_by_sql(sql) 
 end
 
 #查询所有的配置项分类的二级菜单
  def findParamER()
        sql = "select distinct(isnull(param_name,'')) param_name,param_code from param a ,configure_item b  "
        sql += "where a.param_name=b.configure_type and param_class='con_type' and param_code in( "
        sql += "( select distinct(param_code) con_type from param where param_class='con_type') "
        sql += ") " 
        
        Param.find_by_sql(sql) 
  end
  
  #查询标识事件类型
  def findTypeAll(type)
        Param.find(:all,:conditions =>["param_class =? ",type])
  end
  
  #查询小于等于当前状态的所有状态
  def findTypeXiao(param_class,param_name)
    sql = "select * from PARAM where param_class='" + param_class + "' "
    sql += "and PARAM_CODE<= (select PARAM_CODE from PARAM where param_class='" + param_class + "' "
    sql += "and PARAM_NAME='" + param_name + "') "
    Param.find_by_sql(sql) 
  end
end
