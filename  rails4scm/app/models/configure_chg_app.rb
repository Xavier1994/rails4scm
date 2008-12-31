class ConfigureChgApp < ActiveRecord::Base
  self.table_name = "CONFIGURE_CHG_APP"
  self.primary_key = "id"
  attr_accessor :id
  
   def list(pageSize,curPageSize)
     sql = "select distinct aa.id, aa.CONFIGURE_CHG_NO,aa.CONFIGURE_CODE,ab.CONFIGURE_NAME,aa.EVENT_CODE,"
     sql += "aa.EVENT_NAME,aa.RELA_EVENT_NAME,aa.PRE_VERSION,aa.AFT_VERSION,aa.PROJECT_CODE,aa.CURRENT_STATUS "
     sql += " from CONFIGURE_CHG_APP aa,CONF_PUB_APP ab "
     sql += "where aa.CONFIGURE_CODE =ab.CONFIGURE_CODE"
     ConfigureChgApp.paginate_by_sql([sql],:per_page =>pageSize,:page =>curPageSize,:order=>"aa.id")  
   end
  
  def inserinto(id,configure_chg_no,configure_code,event_code,event_name,pre_version,project_code,current_status)
    configureChgApp = ConfigureChgApp.new
    configureChgApp.ID=id[0]
    configureChgApp.CONFIGURE_CHG_NO=configure_chg_no[0]
    configureChgApp.CONFIGURE_CODE=configure_code
    configureChgApp.EVENT_CODE=event_code
    configureChgApp.EVENT_NAME=event_name
    #configureChgApp.RELA_EVENT_NAME=rela_event_name
    configureChgApp.PRE_VERSION=pre_version
    #configureChgApp.AFT_VERSION=aft_version
    #configureChgApp.CONFIG_CHG_TYPE=config_chg_type
    #configureChgApp.CONF_CHG_ORDER=conf_chg_order
    configureChgApp.PROJECT_CODE=project_code
    configureChgApp.CURRENT_STATUS=current_status
    configureChgApp.save
  end
  
  def findCount(event_code,conf_code,conf_vers)
    sql = "select * from configure_chg_app where event_code='" + event_code + "' and configure_code='" + conf_code + "' and pre_version='" + conf_vers + "'"
    ConfigureChgApp.find_by_sql(sql) 
  end
  
  def findConfigureChgApp(event_code,current_status)
    ConfigureChgApp.find(:all,:conditions =>["event_code =? and current_status =?",event_code,current_status])
  end
  
  def findConfigureChgApp(event_code)
    ConfigureChgApp.find(:all,:conditions =>["event_code =? ",event_code])
  end
  
  def findConfigureChgAppAll(pageSize,curPageSize,configure_code,configure_name,event_name,project_code,current_status)
    sql = "SELECT CONFIGURE_CHG_APP.ID,CONFIGURE_CHG_APP.CONFIGURE_CHG_NO,CONFIGURE_CHG_APP.CONFIGURE_CODE, "
    sql += "CONFIGURE_ITEM.CONFIGURE_NAME,CONFIGURE_CHG_APP.EVENT_CODE, EVENT_RECORD.EVENT_NAME,"
    sql += "CONFIGURE_CHG_APP.RELA_EVENT_NAME,CONFIGURE_CHG_APP.PRE_VERSION,CONFIGURE_CHG_APP.AFT_VERSION,"
    sql += "CONFIGURE_CHG_APP.CONFIG_CHG_TYPE,CONFIGURE_CHG_APP.CONF_CHG_ORDER, "
    sql += "CONFIGURE_CHG_APP.PROJECT_CODE,CONFIGURE_CHG_APP.CURRENT_STATUS "
    sql += "FROM CONFIGURE_CHG_APP, EVENT_RECORD,CONFIGURE_ITEM "
    sql += " WHERE ( CONFIGURE_CHG_APP.CONFIGURE_CODE = CONFIGURE_ITEM.CONFIGURE_CODE and EVENT_RECORD.EVENT_CODE=CONFIGURE_CHG_APP.EVENT_CODE) "
    
    if(configure_code != nil and configure_code != "") then
      sql += " AND CONFIGURE_CHG_APP.CONFIGURE_CODE='" + configure_code + "' "
    end
    if(configure_name != nil and configure_name != "") then
      sql += " AND CONFIGURE_ITEM.CONFIGURE_NAME like '%" + configure_name + "%'"
    end
    if(event_name != nil and event_name != "") then
      sql += " AND EVENT_RECORD.EVENT_NAME like '%" + event_name + "%'"
    end
    if(project_code != nil and project_code != "") then
      sql += " AND CONFIGURE_CHG_APP.PROJECT_CODE like '%" + project_code + "%'"
    end
    if(current_status != nil and current_status != "") then
      sql += " AND CONFIGURE_CHG_APP.CURRENT_STATUS = '" + current_status + "'"
    end
    
    #sql += " order by CONFIGURE_CHG_APP.EVENT_CODE desc"
    
    ConfigureChgApp.paginate_by_sql([sql],:per_page =>pageSize,:page =>curPageSize,:order=>"ID")
  end
  
  def findConfigureChgApp_no(configure_chg_no)
    ConfigureChgApp.find(:first,:conditions =>["configure_chg_no =? ",configure_chg_no])
  end
end
