class ConfigureItem < ActiveRecord::Base
  self.table_name = "configure_item"
  self.primary_key = "id"
  
  attr_accessor :id
  
  #��ѯ���е��������������һ���˵�
  def findConfigureItem()
        sql = "select isnull(configure_code,'') code,isnull(configure_name,'') name,configure_type from configure_item where configure_type in( "
        sql += "select distinct(isnull(param_name,'')) param_name from param where param_class='con_type' and param_code in "
        sql += "( select distinct(param_code) con_type from param where param_class='con_type') "
        sql += ") "
        
        ConfigureItem.find_by_sql(sql)
  end
  
  #��ѯ������������Ϣ
  def findConfigureItemCode(configure_code)
       ConfigureItem.find(:all,:conditions =>["configure_code =?",configure_code])
  end
  
  #���ݲ�ͬ������ѯ������
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
end