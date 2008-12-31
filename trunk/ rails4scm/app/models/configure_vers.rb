class ConfigureVers < ActiveRecord::Base
  self.table_name = "configure_version"
  self.primary_key = "id"
  attr_accessor :id
  
  #查询版本信息
  def findConfigureVersList(configure_code)
    sql = "select configure_vers,cur_state,state_date,ver_release,rela_address,"
    sql += "project_name,event_record.event_name,project_manager,event_sponsor,develop_path "
    sql += "from configure_version left outer join configure_chg_app on configure_version.comment = configure_chg_app.configure_chg_no "
    sql += "left outer join event_record on configure_chg_app.event_code = event_record.event_code "
    sql += "left outer join project_msg on event_record.project_code = project_msg.project_code "
    sql += " where configure_version.configure_code='" + configure_code + "'"
    
    ConfigureVers.find_by_sql(sql) 
  end
  
  def findConfigureVersOne(configure_code,pre_version)
    ConfigureVers.find(:first,:conditions =>["configure_code=? and configure_vers=?",configure_code,pre_version])
  end
  
  def findConfigureVers(configure_code,configure_vers)
    ConfigureVers.find(:all,:conditions =>["configure_code=? and configure_vers=?",configure_code,configure_vers])
  end
  
end
