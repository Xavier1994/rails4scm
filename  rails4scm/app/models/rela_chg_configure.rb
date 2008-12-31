class RelaChgConfigure < ActiveRecord::Base
  self.table_name = "rela_chg_configure"
  self.primary_key = "id"
  
  def findRelaChgConfigure(event_code)
    RelaChgConfigure.find(:all,:conditions =>["event_code =?",event_code])
  end
  #≤È—Ø≈‰÷√œÓ
  def findEventConfigItemNum(event_code,configure_code,configure_ver)
        sql = " select count(*) cn "
        sql += "  from rela_chg_configure   "
        sql += " WHERE isnull(event_code,'ø’')='"+event_code +"' and isnull(configure_code,'ø’')='"+configure_code+"' and isnull(configure_vers,'ø’')='"+configure_ver+"'"
        ConfigureItem.find_by_sql(sql)
  end
end
