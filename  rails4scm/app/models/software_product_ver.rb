class SoftwareProductVer < ActiveRecord::Base
   self.table_name = "SOFTWARE_PRODUCT_VER"
   self.primary_key = "id"
  #��ѯ���м�¼
  def productVerList()
     SoftwareProductVer.find(:all)
  end
end
