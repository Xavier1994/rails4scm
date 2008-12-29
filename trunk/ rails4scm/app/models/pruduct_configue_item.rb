class PruductConfigueItem < ActiveRecord::Base
  self.table_name = "SOFTWARE_PRODUCT"
  self.primary_key = "id"
  #查询相关产品
  def getProductConfigueItems(pageSize,curPageSize,product,productVer)
    sql = "SELECT SOFTWARE_PRODUCT.PRODUCT_NAME,SOFTWARE_PRODUCT_VER.PRODUCT_CONF_PERSON,CONFIGURE_ITEM.CONFIGURE_CODE,CONFIGURE_ITEM.CONFIGURE_NAME,CONFIGURE_VERSION.CONFIGURE_VERS,CONFIGURE_ITEM.CONFIGURE_TYPE,CONFIGURE_ITEM.CONFIGURE_STORE_ADDR,CONFIGURE_VERSION.STATE_DATE,CONFIGURE_VERSION.CUR_STATE, PRODUCT_COMP_CONF.PRODUCT_CODE,SOFTWARE_PRODUCT_VER.PRODUCT_VERS "
    sql += "FROM SOFTWARE_PRODUCT, CONFIGURE_ITEM,CONFIGURE_VERSION,PRODUCT_COMP_CONF,SOFTWARE_PRODUCT_VER "
    sql += "WHERE ( SOFTWARE_PRODUCT_VER.PRODUCT_CODE = PRODUCT_COMP_CONF.PRODUCT_CODE )  AND  ( SOFTWARE_PRODUCT_VER.PRODUCT_VERS = PRODUCT_COMP_CONF.PRODUCT_VERS )  AND ( SOFTWARE_PRODUCT_VER.PRODUCT_CODE = SOFTWARE_PRODUCT.PRODUCT_CODE )  AND ( CONFIGURE_VERSION.CONFIGURE_CODE = PRODUCT_COMP_CONF.CONFIGURE_CODE ) AND  ( CONFIGURE_VERSION.CONFIGURE_vers = PRODUCT_COMP_CONF.H_CONFIG_VERS ) AND ( CONFIGURE_VERSION.CONFIGURE_CODE = CONFIGURE_ITEM.CONFIGURE_CODE ) AND ( PRODUCT_COMP_CONF.ACTIVE_STATUS='Y' ) "
    sql +=" AND (SOFTWARE_PRODUCT.PRODUCT_CODE='"+product+"')"
    if (productVer != nil) then
      sql +=" AND (SOFTWARE_PRODUCT_VER.PRODUCT_VERS ='"+productVer+"')"
    end
    PruductConfigueItem.paginate_by_sql([sql],:per_page =>pageSize,:page =>curPageSize)
  end
 
  def productList()
    PruductConfigueItem.find(:all)
  end
  
  def productTreeList()
    sql ="select PRODUCT_CODE,PRODUCT_NAME from SOFTWARE_PRODUCT where PRODUCT_CODE<>'000' order by PRODUCT_CODE "
    PruductConfigueItem.find_by_sql(sql) 
  end
  
  def productBaseinfo(product_code)
    sql ="select * from SOFTWARE_PRODUCT where PRODUCT_CODE='"+product_code+"'"
    PruductConfigueItem.find_by_sql(sql) 
  end
  
    
  def productVersinfo(product_code)
    sql ="SELECT  SOFTWARE_PRODUCT_VER.ID ,SOFTWARE_PRODUCT_VER.PRODUCT_CODE ,SOFTWARE_PRODUCT_VER.PRODUCT_VERS ,SOFTWARE_PRODUCT_VER.COMMENT ,SOFTWARE_PRODUCT_VER.PRODUCT_CONF_PERSON"
    sql +=" FROM SOFTWARE_PRODUCT_VER  where SOFTWARE_PRODUCT_VER.PRODUCT_CODE='"+product_code+"'  order by SOFTWARE_PRODUCT_VER.ID desc "
    PruductConfigueItem.find_by_sql(sql) 
  end   
  
  def productItems(pageSize,curPageSize,product_code,product_vers)
    sql ="SELECT PRODUCT_COMP_CONF.H_CONFIG_VERS,PRODUCT_COMP_CONF.PRODUCT_CODE,PRODUCT_COMP_CONF.PRODUCT_VERS,PRODUCT_COMP_CONF.ACTIVE_STATUS,CONFIGURE_ITEM.ID,PRODUCT_COMP_CONF.CONFIGURE_CODE,CONFIGURE_ITEM.CONFIGURE_NAME,CONFIGURE_ITEM.CONFIGURE_REMARK,CONFIGURE_VERSION.CUR_STATE,CONFIGURE_ITEM.CONFIGURE_TYPE,CONFIGURE_ITEM.CONF_DUTY_PERSON,CONFIGURE_VERSION.STATE_DATE,CONFIGURE_ITEM.CONFIGURE_STORE_ADDR,PRODUCT_COMP_CONF.DEVELOP_PATH,CONFIGURE_VERSION.RELA_ADDRESS,PRODUCT_COMP_CONF.AUTO_DOWN,PRODUCT_COMP_CONF.AUTO_UP"
    sql +=" FROM PRODUCT_COMP_CONF,CONFIGURE_ITEM,CONFIGURE_VERSION  "
    sql +=" WHERE ( PRODUCT_COMP_CONF.CONFIGURE_CODE = CONFIGURE_ITEM.CONFIGURE_CODE ) and  ( CONFIGURE_VERSION.CONFIGURE_CODE = PRODUCT_COMP_CONF.CONFIGURE_CODE ) and  ( CONFIGURE_VERSION.CONFIGURE_VERS = PRODUCT_COMP_CONF.H_CONFIG_VERS ) AND (PRODUCT_COMP_CONF.PRODUCT_CODE='"+product_code+"') AND (PRODUCT_COMP_CONF.PRODUCT_VERS='"+product_vers+"') AND PRODUCT_COMP_CONF.ACTIVE_STATUS='Y'"
    PruductConfigueItem.paginate_by_sql([sql],:per_page =>pageSize,:page =>curPageSize)
  end 
  
  def productItemsHistory(product_code,product_vers,configure_code)
    sql ="SELECT *"
    sql +=" FROM PRODUCT_COMP_CONF  "
    sql +=" WHERE ( PRODUCT_COMP_CONF.CONFIGURE_CODE = '"+configure_code+"' ) AND (PRODUCT_COMP_CONF.PRODUCT_CODE='"+product_code+"') AND (PRODUCT_COMP_CONF.PRODUCT_VERS='"+product_vers+"')"
    PruductConfigueItem.find_by_sql(sql) 
  end 
  
  def  productVerProjects(pageSize,curPageSize,product_code,product_ver)
    
    sql ="SELECT  PROJECT_MSG.PROJECT_CODE ,PROJECT_MSG.PROJECT_NAME ,PROJECT_MSG.PROJECT_MANAGER ,PRJ_CON_RELA.PRODUCT_CODE ,PRJ_CON_RELA.PRODUCT_VERS ,PROJECT_MSG.PROJECT_CONF_PERSON  "
    sql +=" FROM PRJ_CON_RELA ,PROJECT_MSG   "
    sql +=" WHERE ( PRJ_CON_RELA.PROJECT_CODE = PROJECT_MSG.PROJECT_CODE ) AND PRJ_CON_RELA.PRODUCT_CODE='"+product_code+"' AND PRJ_CON_RELA.PRODUCT_VERS='"+product_ver+"' GROUP BY PROJECT_MSG.PROJECT_CODE ,PROJECT_MSG.PROJECT_NAME ,PROJECT_MSG.PROJECT_MANAGER ,PRJ_CON_RELA.PRODUCT_CODE ,PRJ_CON_RELA.PRODUCT_VERS ,PROJECT_MSG.PROJECT_CONF_PERSON "
    PruductConfigueItem.paginate_by_sql([sql],:per_page =>pageSize,:page =>curPageSize)
  end
end
