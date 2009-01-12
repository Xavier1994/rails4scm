class SoftwareProduct < ActiveRecord::Base
  self.table_name = "software_product"
   self.primary_key = "id"
   def getProductByCode(productCode)
    sql = "SELECT * "
    sql += "FROM SOFTWARE_PRODUCT "
    sql += "WHERE (SOFTWARE_PRODUCT.PRODUCT_CODE='"+productCode+"')"
    SoftwareProduct.find_by_sql(sql)
  end
end
