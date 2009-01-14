class ConfigureChgCycleDet < ActiveRecord::Base
  self.table_name = "configure_chg_cycle_det"
  self.primary_key = "id"
  attr_accessor :id
  
  def insertConfigureChgCycleDet(id,configure_chg_no,chg_state,active_status)
    configureChgCycleDet = ConfigureChgCycleDet.new
    configureChgCycleDet.ID=id
    configureChgCycleDet.CONFIGURE_CHG_NO=configure_chg_no
    configureChgCycleDet.CHG_STATE=chg_state
    configureChgCycleDet.ACTIVE_STATUS=active_status
    
    configureChgCycleDet.save
  end
  
  def findConfigureChgCycleDet(configure_chg_no,chg_state)
    ConfigureChgCycleDet.find(:first,:conditions =>["configure_chg_no=? and chg_state=?",configure_chg_no,chg_state])
  end
end
