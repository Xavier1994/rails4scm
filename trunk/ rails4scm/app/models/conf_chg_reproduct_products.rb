class ConfChgReproductProducts < ActiveRecord::Base
  self.table_name = "conf_Chg_reproduct_products"
  self.primary_key = "id"
  attr_accessor :id
  
  #查询未升级的项目
  def findProjectNon(event_code,configure_code,configure_vers)
    sql = "SELECT CONF_CHG_REPROJECT_PROJECTS.PROJECT_CODE,"
    sql += "CONF_CHG_REPROJECT_PROJECTS.CONFIGURE_CODE,"
    sql += "CONF_CHG_REPROJECT_PROJECTS.EVENT_CODE,"
    sql += "PROJECT_MSG.PROJECT_NAME "
    sql += "FROM CONF_CHG_REPROJECT_PROJECTS,PROJECT_MSG "
    sql += "WHERE ( CONF_CHG_REPROJECT_PROJECTS.PROJECT_CODE = PROJECT_MSG.PROJECT_CODE ) and "
    sql += "( ( CONF_CHG_REPROJECT_PROJECTS.exec_status <> '已升级' ) OR "
    sql += "( CONF_CHG_REPROJECT_PROJECTS.exec_status is NULL ) ) "
    sql += "and event_code='" + event_code + "' and configure_code='" + configure_code + "' and configure_vers='" + configure_vers + "'"
    
    ConfChgReproductProducts.find_by_sql(sql )
  end
  
  #查询已升级的项目
  def findProjectBlock(event_code,configure_code,configure_vers)
    sql = "SELECT CONF_CHG_REPROJECT_PROJECTS.PROJECT_CODE,"
    sql += "CONF_CHG_REPROJECT_PROJECTS.CONFIGURE_CODE, "
    sql += "CONF_CHG_REPROJECT_PROJECTS.EVENT_CODE,PROJECT_MSG.PROJECT_NAME "
    sql += "FROM CONF_CHG_REPROJECT_PROJECTS,PROJECT_MSG "
    sql += "WHERE ( CONF_CHG_REPROJECT_PROJECTS.PROJECT_CODE = PROJECT_MSG.PROJECT_CODE ) and "
    sql += "( CONF_CHG_REPROJECT_PROJECTS.exec_status = '已升级' ) "
    sql += "and event_code='" + event_code + "' and configure_code='" + configure_code + "' and configure_vers='" + configure_vers + "'"
    
    ConfChgReproductProducts.find_by_sql(sql )
  end
  #查询未升级的产品
  def findItemNon(event_code,configure_code,configure_vers)
    sql = "SELECT  CONF_CHG_REPRODUCT_PRODUCTS.CONFIGURE_CODE ,"
    sql += "CONF_CHG_REPRODUCT_PRODUCTS.PRODUCT_CODE ,CONF_CHG_REPRODUCT_PRODUCTS.EVENT_CODE ,"
    sql += "SOFTWARE_PRODUCT.PRODUCT_NAME ,CONF_CHG_REPRODUCT_PRODUCTS.PRODUCT_VERS "
    sql += "FROM CONF_CHG_REPRODUCT_PRODUCTS ,SOFTWARE_PRODUCT "
    sql += "WHERE ( SOFTWARE_PRODUCT.PRODUCT_CODE = CONF_CHG_REPRODUCT_PRODUCTS.PRODUCT_CODE ) and  "
    sql += "( ( CONF_CHG_REPRODUCT_PRODUCTS.exec_status <> '已升级' ) or  ( CONF_CHG_REPRODUCT_PRODUCTS.exec_status is NULL ) )"
    sql += "and event_code='" + event_code + "' and configure_code='" + configure_code + "' and configure_vers='" + configure_vers + "'"
    
    ConfChgReproductProducts.find_by_sql(sql )
  end
  #查询已升级的产品
  def findItemBlock(event_code,configure_code,configure_vers)
    sql = "SELECT  CONF_CHG_REPRODUCT_PRODUCTS.CONFIGURE_CODE ,"
    sql += "CONF_CHG_REPRODUCT_PRODUCTS.PRODUCT_CODE ,CONF_CHG_REPRODUCT_PRODUCTS.EVENT_CODE ,"
    sql += "SOFTWARE_PRODUCT.PRODUCT_NAME ,CONF_CHG_REPRODUCT_PRODUCTS.PRODUCT_VERS "
    sql += "FROM CONF_CHG_REPRODUCT_PRODUCTS ,SOFTWARE_PRODUCT "
    sql += "WHERE ( SOFTWARE_PRODUCT.PRODUCT_CODE = CONF_CHG_REPRODUCT_PRODUCTS.PRODUCT_CODE ) and "
    sql += "( CONF_CHG_REPRODUCT_PRODUCTS.exec_status = '已升级' )"
    sql += "and event_code='" + event_code + "' and configure_code='" + configure_code + "' and configure_vers='" + configure_vers + "'"
    
    ConfChgReproductProducts.find_by_sql(sql )
  end
  #查询配置项组件列表
  def findAllCols(event_code,configure_code,configure_vers)
     ConfChgReproductProducts.find(:all,:conditions=>["event_code =? and configure_code =? and configure_vers=?",event_code,configure_code,configure_vers])
  end
  
  def findByEvencodeConfcodeConfver(event_code,configure_code,configure_ver)
    sql = "SELECT CONF_CHG_REPRODUCT_PRODUCTS.ID CID,CONF_CHG_REPRODUCT_PRODUCTS.EVENT_CODE,CONF_CHG_REPRODUCT_PRODUCTS.CONFIGURE_CODE,SOFTWARE_PRODUCT.PRODUCT_NAME,CONF_CHG_REPRODUCT_PRODUCTS.CONFIGURE_VERS,CONF_CHG_REPRODUCT_PRODUCTS.PRODUCT_CODE,CONF_CHG_REPRODUCT_PRODUCTS.PRODUCT_VERS,CONF_CHG_REPRODUCT_PRODUCTS.EXEC_STATUS,CONF_CHG_REPRODUCT_PRODUCTS.CAN_USE_FLAG,SOFTWARE_PRODUCT.H_PRO_VERS,SOFTWARE_PRODUCT.PRODUCT_CODE,SOFTWARE_PRODUCT.ID  "
    sql += " FROM CONF_CHG_REPRODUCT_PRODUCTS, SOFTWARE_PRODUCT "
    sql += " WHERE ( CONF_CHG_REPRODUCT_PRODUCTS.PRODUCT_CODE = SOFTWARE_PRODUCT.PRODUCT_CODE ) and EVENT_CODE='" + event_code + "' and CONFIGURE_CODE='"+configure_code+"' and CONFIGURE_VERS='"+configure_ver+"'"
     ConfChgReproductProducts.find_by_sql(sql)
  end
      
end
