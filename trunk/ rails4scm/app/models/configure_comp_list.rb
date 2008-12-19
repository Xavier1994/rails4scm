class ConfigureCompList < ActiveRecord::Base
  self.table_name = "configure_comp_list"
  self.primary_key = "id"
  
  #查询配置项组件列表
  def findConfigureCompListList(configure_code)
     ConfigureCompList.find(:all,:conditions=>["configure_code =?",configure_code])
  end
end
