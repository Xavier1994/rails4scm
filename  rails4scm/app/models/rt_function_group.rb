class RtFunctionGroup < ActiveRecord::Base 
    self.table_name = "rt_function_group"
    self.primary_key = "func_group_id"
    
    acts_as_list 
    
    def findSystemGroup(funcGroupIds)
      sql = "select func_group_name,'#' url,up_group_id,func_group_id from RT_FUNCTION_GROUP t where t.func_group_id "
      sql += "in (" + funcGroupIds + ")"
      
      RtFunctionGroup.find_by_sql(sql) 
    end
    
    def findSystemGroupUp(upGroupIds)
      sql = "select func_group_name,'#' url,func_group_id from RT_FUNCTION_GROUP t where t.func_group_id "
      sql += "in (" + upGroupIds + ")"
      
      RtFunctionGroup.find_by_sql(sql) 
    end
end
