class ConfigureItem < ActiveRecord::Base
  self.table_name = "configure_item"
  self.primary_key = "id"
  
  
  #查询所有的配置项分类的最后一级菜单
  def findConfigureItem()
        sql = "select isnull(configure_code,'') code,isnull(configure_name,'') name,configure_type from configure_item where configure_type in( "
        sql += "select distinct(isnull(param_name,'')) param_name from param where param_class='con_type' and param_code in "
        sql += "( select distinct(param_code) con_type from param where param_class='con_type') "
        sql += ") "
        
        ConfigureItem.find_by_sql(sql)
  end
  
  #查询配置项分类的信息
  def findConfigureItemCode(configure_code)
       ConfigureItem.find(:all,:conditions =>["configure_code =?",configure_code])
  end
  
  #根据不同条件查询配置项
  def findItemAll(pageSize,curPageSize,configure_name,configure_type,configure_code)
       sql = "select * from configure_item "
       if(configure_name != nil or configure_type != nil or configure_code != nil) then
          where = " where "
          if(configure_name != nil) then
            where += "configure_name like '%" + configure_name + "%' and "
          end
          if(configure_type != nil) then
            where += "configure_type like '%" + configure_type + "%' and "
          end
          if(configure_code != nil) then
            where += "configure_code like '%" + configure_code + "%' and "
          end
          whre_a = ""
          if(where != "" and where != nil) then
             where = (where.strip).split(//)
             i = where.size-3
             k = 0
             for j in where
               whre_a += j
               k = k + 1
               if(k == i) then
                 break
               end
             end
          end 
          sql += whre_a
       end
       ConfigureItem.paginate_by_sql([sql],:per_page =>pageSize,:page =>curPageSize,:order=>"id")
  end
  
  def fenYe(pageSize,curPageSize)
    ConfigureItem.paginate(:per_page =>pageSize, :page =>curPageSize,:order=>"id")
  end
  
end
