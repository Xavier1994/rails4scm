class Scm::Event::Query::NeedSourceItemsController < ApplicationController

  def index
    id = params[:id]
    if(id != nil)
      @relachg = RelaChgConfigure.find(:first,:conditions =>["ID=? ",id])
      @configitem = ConfigureItem.find(:first,:conditions =>["configure_code =?",@relachg.CONFIGURE_CODE])

      is_where=" and configure_code='" + @relachg.CONFIGURE_CODE + "' and event_code='" + @relachg.EVENT_CODE + "' and configure_vers='" + @relachg.CONFIGURE_VERS  + "'"

      #查询涉及项目
      sql = "SELECT  CONF_CHG_REPROJECT_PROJECTS.ID ,"
      sql += "CONF_CHG_REPROJECT_PROJECTS.EVENT_CODE ,"
      sql += "CONF_CHG_REPROJECT_PROJECTS.CONFIGURE_CODE ,"
      sql += "CONF_CHG_REPROJECT_PROJECTS.CONFIGURE_VERS,"
      sql += "CONF_CHG_REPROJECT_PROJECTS.PROJECT_CODE ,"
      sql += "CONF_CHG_REPROJECT_PROJECTS.CAN_USE_FLAG ,"
      sql += "PROJECT_MSG.PROJECT_NAME "
      sql += "FROM CONF_CHG_REPROJECT_PROJECTS ,PROJECT_MSG "
      sql += "WHERE ( CONF_CHG_REPROJECT_PROJECTS.PROJECT_CODE = PROJECT_MSG.PROJECT_CODE )"
      sql += is_where
      @project = ProjectMsg.find_by_sql(sql)

      #查询涉及产品
      sql = ""
      sql += "SELECT CONF_CHG_REPRODUCT_PRODUCTS.ID,"
      sql += "CONF_CHG_REPRODUCT_PRODUCTS.EVENT_CODE, "
      sql += "CONF_CHG_REPRODUCT_PRODUCTS.CONFIGURE_CODE,"
      sql += "SOFTWARE_PRODUCT.PRODUCT_NAME,"
      sql += "CONF_CHG_REPRODUCT_PRODUCTS.CONFIGURE_VERS,"
      sql += "CONF_CHG_REPRODUCT_PRODUCTS.PRODUCT_CODE,"
      sql += "CONF_CHG_REPRODUCT_PRODUCTS.PRODUCT_VERS,"
      sql += "CONF_CHG_REPRODUCT_PRODUCTS.EXEC_STATUS, "
      sql += "CONF_CHG_REPRODUCT_PRODUCTS.CAN_USE_FLAG,"
      sql += "SOFTWARE_PRODUCT.H_PRO_VERS "
      #sql += "SOFTWARE_PRODUCT.ID "
      sql += "FROM CONF_CHG_REPRODUCT_PRODUCTS,SOFTWARE_PRODUCT "
      sql += "WHERE ( CONF_CHG_REPRODUCT_PRODUCTS.PRODUCT_CODE = SOFTWARE_PRODUCT.PRODUCT_CODE ) "
      sql += is_where
      @software = SoftwareProductVer.find_by_sql(sql)
    end
    
    @maxRows = 5
  end
end
