class ProjectMsg < ActiveRecord::Base
  self.table_name = "project_msg"
  self.primary_key = "id"
  
  def findProjectMsgAll()
    ProjectMsg.find(:all)
  end
end
