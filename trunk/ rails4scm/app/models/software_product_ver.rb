class SoftwareProductVer < ActiveRecord::Base
   self.table_name = "SOFTWARE_PRODUCT_VER"
   self.primary_key = "id"
  #��ѯ���м�¼
  def productVerList(product_code)
    sql="SELECT * FROM SOFTWARE_PRODUCT_VER WHERE PRODUCT_CODE='"+product_code+"'"
     SoftwareProductVer.find_by_sql(sql)
  end
end
