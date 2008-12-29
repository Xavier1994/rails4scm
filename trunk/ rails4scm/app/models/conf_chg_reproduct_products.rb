class ConfChgReproductProducts < ActiveRecord::Base
  self.table_name = "conf_Chg_reproduct_products"
  self.primary_key = "id"
  
  #��ѯδ��������Ŀ
  def findProjectNon(event_code,configure_code,configure_vers)
    sql = "SELECT CONF_CHG_REPROJECT_PROJECTS.PROJECT_CODE,"
    sql += "CONF_CHG_REPROJECT_PROJECTS.CONFIGURE_CODE,"
    sql += "CONF_CHG_REPROJECT_PROJECTS.EVENT_CODE,"
    sql += "PROJECT_MSG.PROJECT_NAME "
    sql += "FROM CONF_CHG_REPROJECT_PROJECTS,PROJECT_MSG "
    sql += "WHERE ( CONF_CHG_REPROJECT_PROJECTS.PROJECT_CODE = PROJECT_MSG.PROJECT_CODE ) and "
    sql += "( ( CONF_CHG_REPROJECT_PROJECTS.exec_status <> '������' ) OR "
    sql += "( CONF_CHG_REPROJECT_PROJECTS.exec_status is NULL ) ) "
    sql += "and event_code='" + event_code + "' and configure_code='" + configure_code + "' and configure_vers='" + configure_vers + "'"
    
    ConfChgReproductProducts.find_by_sql(sql )
  end
  
  #��ѯ����������Ŀ
  def findProjectBlock(event_code,configure_code,configure_vers)
    sql = "SELECT CONF_CHG_REPROJECT_PROJECTS.PROJECT_CODE,"
    sql += "CONF_CHG_REPROJECT_PROJECTS.CONFIGURE_CODE, "
    sql += "CONF_CHG_REPROJECT_PROJECTS.EVENT_CODE,PROJECT_MSG.PROJECT_NAME "
    sql += "FROM CONF_CHG_REPROJECT_PROJECTS,PROJECT_MSG "
    sql += "WHERE ( CONF_CHG_REPROJECT_PROJECTS.PROJECT_CODE = PROJECT_MSG.PROJECT_CODE ) and "
    sql += "( CONF_CHG_REPROJECT_PROJECTS.exec_status = '������' ) "
    sql += "and event_code='" + event_code + "' and configure_code='" + configure_code + "' and configure_vers='" + configure_vers + "'"
    
    ConfChgReproductProducts.find_by_sql(sql )
  end
  #��ѯδ�����Ĳ�Ʒ
  def findItemNon(event_code,configure_code,configure_vers)
    sql = "SELECT  CONF_CHG_REPRODUCT_PRODUCTS.CONFIGURE_CODE ,"
    sql += "CONF_CHG_REPRODUCT_PRODUCTS.PRODUCT_CODE ,CONF_CHG_REPRODUCT_PRODUCTS.EVENT_CODE ,"
    sql += "SOFTWARE_PRODUCT.PRODUCT_NAME ,CONF_CHG_REPRODUCT_PRODUCTS.PRODUCT_VERS "
    sql += "FROM CONF_CHG_REPRODUCT_PRODUCTS ,SOFTWARE_PRODUCT "
    sql += "WHERE ( SOFTWARE_PRODUCT.PRODUCT_CODE = CONF_CHG_REPRODUCT_PRODUCTS.PRODUCT_CODE ) and  "
    sql += "( ( CONF_CHG_REPRODUCT_PRODUCTS.exec_status <> '������' ) or  ( CONF_CHG_REPRODUCT_PRODUCTS.exec_status is NULL ) )"
    sql += "and event_code='" + event_code + "' and configure_code='" + configure_code + "' and configure_vers='" + configure_vers + "'"
    
    ConfChgReproductProducts.find_by_sql(sql )
  end
  #��ѯ�������Ĳ�Ʒ
  def findItemBlock(event_code,configure_code,configure_vers)
    sql = "SELECT  CONF_CHG_REPRODUCT_PRODUCTS.CONFIGURE_CODE ,"
    sql += "CONF_CHG_REPRODUCT_PRODUCTS.PRODUCT_CODE ,CONF_CHG_REPRODUCT_PRODUCTS.EVENT_CODE ,"
    sql += "SOFTWARE_PRODUCT.PRODUCT_NAME ,CONF_CHG_REPRODUCT_PRODUCTS.PRODUCT_VERS "
    sql += "FROM CONF_CHG_REPRODUCT_PRODUCTS ,SOFTWARE_PRODUCT "
    sql += "WHERE ( SOFTWARE_PRODUCT.PRODUCT_CODE = CONF_CHG_REPRODUCT_PRODUCTS.PRODUCT_CODE ) and "
    sql += "( CONF_CHG_REPRODUCT_PRODUCTS.exec_status = '������' )"
    sql += "and event_code='" + event_code + "' and configure_code='" + configure_code + "' and configure_vers='" + configure_vers + "'"
    
    ConfChgReproductProducts.find_by_sql(sql )
  end
end
