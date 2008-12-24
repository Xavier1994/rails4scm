class SoftwareProductVer < ActiveRecord::Base
   self.table_name = "SOFTWARE_PRODUCT_VER"
   self.primary_key = "id"
  #查询所有记录
  def productVerList()
     SoftwareProductVer.find(:all)
  end
end
