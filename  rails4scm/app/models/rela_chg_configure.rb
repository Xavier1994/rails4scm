class RelaChgConfigure < ActiveRecord::Base
  self.table_name = "rela_chg_configure"
  self.primary_key = "id"
  
  def findRelaChgConfigure(event_code)
    RelaChgConfigure.find(:all,:conditions =>["event_code =?",event_code])
  end
  #��ѯ������
  def findEventConfigItemNum(event_code,configure_code)
        sql = " select count(*) cn "
        sql += "  from rela_chg_configure   "
        sql += " WHERE isnull(event_code,'��')='"+event_code +"' and isnull(configure_code,'��')='"+configure_code+"'"
        RelaChgConfigure.find_by_sql(sql)
  end
   #��ѯ������
  def findEventConfigItem(event_code,configure_code)
        sql = " select * "
        sql += "  from rela_chg_configure   "
        sql += " WHERE isnull(event_code,'��')='"+event_code +"' and isnull(configure_code,'��')='"+configure_code+"'"
        RelaChgConfigure.find_by_sql(sql)
  end
  #��ѯ������
  def findEventAppConfigItemNum(event_code,configure_code,configure_ver)
        sql = " select  count(*) cn "
        sql += "  from configure_chg_app   "
        sql += " WHERE isnull(event_code,'��')='"+event_code +"' and isnull(configure_code,'��')='"+configure_code+"' and isnull(pre_version,'��')='"+configure_ver+"'"
        RelaChgConfigure.find_by_sql(sql)
  end
  #��ѯ����������б�
  def findAllCols(event_code,configure_code,configure_vers)
     RelaChgConfigure.find(:all,:conditions=>["event_code =? and configure_code =? and configure_vers=?",event_code,configure_code,configure_vers])
  end
end
