class ConfigureCompList < ActiveRecord::Base
  self.table_name = "configure_comp_list"
  self.primary_key = "id"
  
  #��ѯ����������б�
  def findConfigureCompListList(configure_code)
     ConfigureCompList.find(:all,:conditions=>["configure_code =?",configure_code])
  end
end
