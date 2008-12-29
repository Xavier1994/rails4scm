class RelaChgConfigure < ActiveRecord::Base
  self.table_name = "rela_chg_configure"
  self.primary_key = "id"
  
  def findRelaChgConfigure(event_code)
    RelaChgConfigure.find(:all,:conditions =>["event_code =?",event_code])
  end
  
end
