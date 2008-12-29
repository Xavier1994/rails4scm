class ConfigureVersion < ActiveRecord::Base
  self.table_name = "configure_version"
  self.primary_key = "id"
  
  def updateConfigureVersion(configure_code,configure_vers,cur_state,state_date,comment)
    configureVersion = ConfigureVersion.find(:first,:conditions =>["configure_code =? and configure_vers=?",configure_code,configure_vers])
    configureVersion.id = configureVersion.ID
    configureVersion.CUR_STATE=cur_state
    configureVersion.STATE_DATE=state_date
    configureVersion.COMMENT=comment
    configureVersion.save
  end
  
end
