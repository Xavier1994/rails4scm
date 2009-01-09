class Scm::Item::Change::ItemUpgradeDepictController < ApplicationController

  def index
    @configure_chg_no = params[:configure_chg_no]
    @configurechg = ConfigureChgApp.find(@configure_chg_no)
    @configitem   = ConfigureItem.find(:first,:conditions =>["configure_code =?",@configurechg.CONFIGURE_CODE])

    is_where=" and configure_code='" + @configurechg.CONFIGURE_CODE + "' "
    is_where+=" and event_code='" + @configurechg.EVENT_CODE + "'";
    is_where+=" and configure_vers='" + @configurechg.PRE_VERSION + "'"
    
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
    sql += "FROM CONF_CHG_REPRODUCT_PRODUCTS,SOFTWARE_PRODUCT "
    sql += "WHERE ( CONF_CHG_REPRODUCT_PRODUCTS.PRODUCT_CODE = SOFTWARE_PRODUCT.PRODUCT_CODE ) "
    sql += is_where
    @software = SoftwareProductVer.find_by_sql(sql)
    
    @maxRows = 10
    if(@project.size != 0 || @software.size != 0)
      if(@project.size>@software.size)
        @maxRows=@project.size
      else
        @maxRows=@software.size
      end
      if(@maxRows < 10)
        @maxRows = 10
      end
    end
    
  end
end
