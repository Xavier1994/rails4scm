class PrjConRela < ActiveRecord::Base
  self.table_name = "prj_con_rela"
  self.primary_key = "id"
  
  #��ѯ�����Ŀ
  #configure_code -- ��������
  #h_config_vers  -- �汾��
  def findPrjConRela(configure_code,configure_vers)
    sql = "select prj_con_rela.project_code ,project_name ,project_manager ,conf_m_respon ,"
    sql += "configure_code ,configure_vers ,project_conf_person  "
    sql += "from prj_con_rela ,project_msg "
    sql += " where ( prj_con_rela.project_code = project_msg.project_code ) "
    sql += " and prj_con_rela.configure_code='" + configure_code + "'  and prj_con_rela.configure_vers='" + configure_vers + "' "
    
    PrjConRela.find_by_sql(sql)
  end
end
