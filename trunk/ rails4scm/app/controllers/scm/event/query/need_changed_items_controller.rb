class Scm::Event::Query::NeedChangedItemsController < ApplicationController

  def index
   @event_code = params[:event_code]
   curPageSize = params[:page]
   pageSize = 20
   sql = "SELECT  RELA_CHG_CONFIGURE.ID ,RELA_CHG_CONFIGURE.CONFIGURE_CODE ,"
   sql += "RELA_CHG_CONFIGURE.EVENT_CODE , RELA_CHG_CONFIGURE.CONFIGURE_VERS ,"
   sql += "RELA_CHG_CONFIGURE.M_CONFIG_FLAG ,CONFIGURE_ITEM.CONFIGURE_NAME "
   sql += " FROM RELA_CHG_CONFIGURE ,CONFIGURE_ITEM "
   sql += " WHERE ( RELA_CHG_CONFIGURE.CONFIGURE_CODE = CONFIGURE_ITEM.CONFIGURE_CODE ) "
   sql += " and RELA_CHG_CONFIGURE.EVENT_CODE='" + @event_code + "'"
   
    #@relachg = RelaChgConfigure.find_by_sql(sql)
    @event   = EventRecord.find(:first,:conditions =>["event_code=? ",@event_code])
    @relachg = RelaChgConfigure.paginate_by_sql([sql],:per_page =>pageSize,:page =>curPageSize,:order=>"id")
  end
end
