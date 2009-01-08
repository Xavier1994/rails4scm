class ConfigureItem < ActiveRecord::Base
  self.table_name = "configure_item"
  self.primary_key = "id"
  
  attr_accessor :id
  
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
            configure_name = configure_name.lstrip
            configure_name = configure_name.rstrip
            where += "configure_name like '%" + configure_name + "%' and "
          end
          if(configure_type != nil) then
            configure_type = configure_type.lstrip
            configure_type = configure_type.rstrip
            where += "configure_type like '%" + configure_type + "%' and "
          end
          if(configure_code != nil) then
            configure_code = configure_code.lstrip
            configure_code = configure_code.rstrip
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
  
  def findConfig(pageSize,curPageSize,event_code)
    sql = "select * from ("
    sql += "SELECT CONFIGURE_ITEM.ID,CONFIGURE_ITEM.CONFIGURE_NAME,CONFIGURE_CHG_APP.PRE_VERSION,"
    sql += "CONFIGURE_ITEM.CONFIGURE_CODE,CONFIGURE_CHG_APP.AFT_VERSION FROM CONFIGURE_CHG_APP,CONFIGURE_ITEM "
    sql += "WHERE ( CONFIGURE_CHG_APP.CONFIGURE_CODE = CONFIGURE_ITEM.CONFIGURE_CODE ) "
    sql += "and CONFIGURE_CHG_APP.event_code='" + event_code + "') a "
    
    ConfigureItem.paginate_by_sql([sql],:per_page =>pageSize,:page =>curPageSize,:order=>"id")
  end
  
  def findConfigOne(config_code,event_code)
    sql = "SELECT CONFIGURE_ITEM.ID,CONFIGURE_ITEM.CONFIGURE_NAME,CONFIGURE_CHG_APP.PRE_VERSION,"
    sql += "CONFIGURE_ITEM.CONFIGURE_CODE,CONFIGURE_CHG_APP.AFT_VERSION FROM CONFIGURE_CHG_APP,CONFIGURE_ITEM "
    sql += "WHERE ( CONFIGURE_CHG_APP.CONFIGURE_CODE = CONFIGURE_ITEM.CONFIGURE_CODE ) "
    sql += "and CONFIGURE_CHG_APP.event_code='" + event_code + "'"
    sql += "and CONFIGURE_CHG_APP.CONFIGURE_CODE='" + config_code + "'"
    
    ConfigureItem.find_by_sql(sql) 
  end
  
  #查询该事件对应所有的配置项
  def findEventConfigureItem(configure_name,configure_type)
        sql = " SELECT CONFIGURE_ITEM.CONFIGURE_NAME,CONFIGURE_VERSION.CONFIGURE_VERS, CONFIGURE_VERSION.CUR_STATE,CONFIGURE_ITEM.CONFIGURE_CODE , CONFIGURE_ITEM.CONFIGURE_TYPE "
        sql += " FROM CONFIGURE_ITEM, CONFIGURE_VERSION   "
        sql += " WHERE ( CONFIGURE_ITEM.CONFIGURE_CODE = CONFIGURE_VERSION.CONFIGURE_CODE ) and  ( ( CONFIGURE_VERSION.CUR_STATE <> '检出-变更' ) )  AND CONFIGURE_ITEM.CONFIGURE_TYPE like '%"+configure_type+"%' AND CONFIGURE_ITEM.CONFIGURE_NAME like '%"+configure_name+"%' ORDER BY CONFIGURE_ITEM.CONFIGURE_NAME ASC"
        ConfigureItem.find_by_sql(sql)
  end
  
   #查询该事件对应所有的配置项
  def findEventConfigureItemSelected(event_code)
        sql = " SELECT  RELA_CHG_CONFIGURE.ID ,RELA_CHG_CONFIGURE.CONFIGURE_CODE ,RELA_CHG_CONFIGURE.EVENT_CODE ,RELA_CHG_CONFIGURE.CONFIGURE_VERS ,RELA_CHG_CONFIGURE.M_CONFIG_FLAG ,CONFIGURE_ITEM.CONFIGURE_NAME "
        sql += " FROM RELA_CHG_CONFIGURE ,CONFIGURE_ITEM  "
        sql += " WHERE ( RELA_CHG_CONFIGURE.CONFIGURE_CODE = CONFIGURE_ITEM.CONFIGURE_CODE ) AND EVENT_CODE='"+event_code+"'  ORDER BY RELA_CHG_CONFIGURE.ID DESC"
        ConfigureItem.find_by_sql(sql)
  end

end
