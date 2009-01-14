class Scm::Item::Query::ItemUpgradeDepictController < ApplicationController

  def index
    @configure_chg_no = params[:configure_chg_no]
    @configurechg = ConfigureChgApp.find(@configure_chg_no)
    @configitem   = ConfigureItem.find(:first,:conditions =>["configure_code =?",@configurechg.CONFIGURE_CODE])
    click = params[:click_hidden]
    
    mess="保存@W项目@W产品@W成功!@W失败!@W和@W没有记录不能保存@W"
    message = mess.split("@W")
    @message = ""
    #只保存项目
    if(click == "1")
      if(params[:project] == nil)
        @message=message[1]+message[6]
      else
        begin
          for param in params[:project]
            reco=param[1]
            pro = ProjectMsg.find(reco[:ID])
            pro.id=pro.ID
            pro.CAN_USE_FLAG=reco[:CAN_USE_FLAG]
            pro.save
          end
          @message=message[0] + message[1] + message[3]
        rescue Exception => e
          @message=message[0] + message[1] + message[4]
        end
      end
    end
    
    #只保存产品
    if(click == "2")
      if(params[:software] == nil)
        @message=message[2]+message[6]
      else
        begin
          for param in params[:software]
            reco=param[1]
            conf = ConfChgReproductProducts.find(reco[:ID])
            conf.id=conf.ID
            conf.CAN_USE_FLAG=reco[:CAN_USE_FLAG]
            conf.save
          end
          @message=message[0] + message[2] + message[3]
        rescue Exception => e
          @message=message[0] + message[2] + message[4]
        end
      end
    end
    
    #保存项目和产品
    if(click == "3")
      if(params[:project] == nil && params[:software] == nil)
        @message=message[1] + message[5] + message[2]+message[6]
      else
        begin
          ProjectMsg.transaction do
            if(params[:project] != nil)
              for param in params[:project]
                reco=param[1]
                pro = ProjectMsg.find(reco[:ID])
                pro.id=pro.ID
                pro.CAN_USE_FLAG=reco[:CAN_USE_FLAG]
                pro.save
              end
            end

            if(params[:software] != nil)
              for param in params[:software]
                reco=param[1]
                conf = ConfChgReproductProducts.find(reco[:ID])
                conf.id=conf.ID
                conf.CAN_USE_FLAG=reco[:CAN_USE_FLAG]
                conf.save
              end
            end
            @message=message[0] + message[1] + message[5] + message[2] + message[3]
          end
        rescue Exception => e
          @message=message[0] + message[1] + message[5] + message[2] + message[4]
        end
      end
    end
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
    #sql += "SOFTWARE_PRODUCT.ID "
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
