class PruductConfigueItem < ActiveRecord::Base
  self.table_name = "SOFTWARE_PRODUCT"
  self.primary_key = "id"
  #查询相关产品
  def getProductConfigueItems(pageSize,curPageSize,product,productVer)
    sql = "SELECT SOFTWARE_PRODUCT.PRODUCT_CODE, SOFTWARE_PRODUCT.PRODUCT_NAME,SOFTWARE_PRODUCT_VER.PRODUCT_CONF_PERSON,CONFIGURE_ITEM.CONFIGURE_CODE,CONFIGURE_ITEM.CONFIGURE_NAME,CONFIGURE_VERSION.CONFIGURE_VERS,CONFIGURE_ITEM.CONFIGURE_TYPE,SOFTWARE_PRODUCT_VER.PRODUCT_CONF_PERSON,CONFIGURE_ITEM.CONFIGURE_STORE_ADDR,CONFIGURE_VERSION.STATE_DATE,CONFIGURE_VERSION.CUR_STATE, PRODUCT_COMP_CONF.PRODUCT_CODE,SOFTWARE_PRODUCT_VER.PRODUCT_VERS "
    sql += "FROM SOFTWARE_PRODUCT, CONFIGURE_ITEM,CONFIGURE_VERSION,PRODUCT_COMP_CONF,SOFTWARE_PRODUCT_VER "
    sql += "WHERE ( SOFTWARE_PRODUCT_VER.PRODUCT_CODE = PRODUCT_COMP_CONF.PRODUCT_CODE )  AND  ( SOFTWARE_PRODUCT_VER.PRODUCT_VERS = PRODUCT_COMP_CONF.PRODUCT_VERS )  AND ( SOFTWARE_PRODUCT_VER.PRODUCT_CODE = SOFTWARE_PRODUCT.PRODUCT_CODE )  AND ( CONFIGURE_VERSION.CONFIGURE_CODE = PRODUCT_COMP_CONF.CONFIGURE_CODE ) AND  ( CONFIGURE_VERSION.CONFIGURE_vers = PRODUCT_COMP_CONF.H_CONFIG_VERS ) AND ( CONFIGURE_VERSION.CONFIGURE_CODE = CONFIGURE_ITEM.CONFIGURE_CODE ) AND ( PRODUCT_COMP_CONF.ACTIVE_STATUS='Y' ) "
    if(product != nil && productVer != nil) then
      sql +=" AND (SOFTWARE_PRODUCT.PRODUCT_CODE='"+product+"') AND (SOFTWARE_PRODUCT_VER.PRODUCT_VERS ='"+productVer+"')"
    elsif (product != nil && productVer == nil) then
      sql +=" AND (SOFTWARE_PRODUCT.PRODUCT_CODE='"+product+"')"
    elsif (product == nil && productVer != nil) then
      sql +=" AND (SOFTWARE_PRODUCT_VER.PRODUCT_VERS ='"+productVer+"')"
    end
    PruductConfigueItem.find_by_sql(sql) 
    #PruductConfigueItem.paginate_by_sql([sql],:per_page =>pageSize,:page =>curPageSize)
  end
 
  def productList()
    PruductConfigueItem.find(:all)
  end
  
  def productTreeList()
    sql ="select PRODUCT_CODE,PRODUCT_NAME from SOFTWARE_PRODUCT where PRODUCT_CODE<>'000' order by PRODUCT_CODE "
    PruductConfigueItem.find_by_sql(sql) 
  end
  
end
