class ConfigureChgCycleDet < ActiveRecord::Base
  self.table_name = "configure_chg_cycle_det"
  self.primary_key = "id"
  
  def insertConfigureChgCycleDet(id,configure_chg_no,chg_state,active_status)
    configureChgCycleDet = ConfigureChgCycleDet.new
    configureChgCycleDet.ID=id[0]
    configureChgCycleDet.CONFIGURE_CHG_NO=configure_chg_no[0]
    configureChgCycleDet.CHG_STATE=chg_state
    configureChgCycleDet.ACTIVE_STATUS=active_status
    
    configureChgCycleDet.save
  end
end
