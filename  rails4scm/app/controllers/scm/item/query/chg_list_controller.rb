class Scm::Item::Query::ChgListController < ApplicationController

  def index
    @configure_chg_no = params[:configure_chg_no]
    @configurechg = ConfigureChgApp.find(@configure_chg_no)
    @configure_code = @configurechg.CONFIGURE_CODE
    
    sql = "SELECT  CONFIGURE_CHG_APP.CONFIGURE_CHG_NO ,CONFIGURE_CHG_APP.PRE_VERSION ,"
    sql += "CONFIGURE_CHG_APP.AFT_VERSION ,EVENT_RECORD.EVENT_NAME ,"
    sql += "EVENT_RECORD.EVENT_SPONSOR ,EVENT_RECORD.EVENT_TIME ,"
    sql += "PROJECT_MSG.PROJECT_NAME ,PROJECT_MSG.PROJECT_MANAGER ,"
    sql += "PROJECT_MSG.DUTY_PERSON ,PROJECT_MSG.PROJECT_CONF_PERSON ,"
    sql += "CONFIGURE_ITEM.CONFIGURE_NAME ,CONFIGURE_CHG_APP.CONFIGURE_CODE ,"
    sql += "CONFIGURE_ITEM.CONFIGURE_TYPE  "
    sql += "FROM CONFIGURE_CHG_APP ,EVENT_RECORD ,PROJECT_MSG ,CONFIGURE_ITEM "
    sql += "WHERE ( CONFIGURE_CHG_APP.EVENT_CODE = EVENT_RECORD.EVENT_CODE ) and "
    sql += " ( EVENT_RECORD.PROJECT_CODE = PROJECT_MSG.PROJECT_CODE ) and "
    sql += " ( CONFIGURE_CHG_APP.CONFIGURE_CODE = CONFIGURE_ITEM.CONFIGURE_CODE ) "
    sql += " and configure_chg_app.configure_code='" + @configure_code + "'"
    
    @config = ConfigureChgApp.find_by_sql(sql) 
  end
end
