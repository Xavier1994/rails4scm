class ConfigureChgApp < ActiveRecord::Base
  self.table_name = "CONFIGURE_CHG_APP"
  self.primary_key = "id"
  
   def list(pageSize,curPageSize)
     sql = "select distinct aa.id, aa.CONFIGURE_CHG_NO,aa.CONFIGURE_CODE,ab.CONFIGURE_NAME,aa.EVENT_CODE,"
     sql += "aa.EVENT_NAME,aa.RELA_EVENT_NAME,aa.PRE_VERSION,aa.AFT_VERSION,aa.PROJECT_CODE,aa.CURRENT_STATUS "
     sql += " from CONFIGURE_CHG_APP aa,CONF_PUB_APP ab "
     sql += "where aa.CONFIGURE_CODE =ab.CONFIGURE_CODE"
     ConfigureChgApp.paginate_by_sql([sql],:per_page =>pageSize,:page =>curPageSize,:order=>"aa.id")  
   end
  
end
