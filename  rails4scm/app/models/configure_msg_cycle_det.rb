class ConfigureMsgCycleDet < ActiveRecord::Base
  self.table_name = "configure_msg_cycle_det"
  self.primary_key = "id"
  
  attr_accessor :id
  
  def findConfigureMsgCycleDet(event_code,current_statue)
     data = ConfigureMsgCycleDet.find(:first,:conditions =>["event_code=? and event_state =?",event_code,current_statue])
     return data
  end
end
