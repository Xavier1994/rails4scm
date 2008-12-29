class Param < ActiveRecord::Base
  self.table_name = "param"
  self.primary_key = "id"
  
 #���͵Ĵ���[��������ඥ��]һ��
 def findParamAll()
        sql = "select distinct(param_code) con_type from param where param_class='con_type'"
        
        Param.find_by_sql(sql) 
 end
 
 #��ѯ���е����������Ķ����˵�
  def findParamER()
        sql = "select distinct(isnull(param_name,'')) param_name,param_code from param a ,configure_item b  "
        sql += "where a.param_name=b.configure_type and param_class='con_type' and param_code in( "
        sql += "( select distinct(param_code) con_type from param where param_class='con_type') "
        sql += ") " 
        
        Param.find_by_sql(sql) 
  end
  
  #��ѯ��ʶ�¼�����
  def findTypeAll(type)
        Param.find(:all,:conditions =>["param_class =? ",type])
  end
end
