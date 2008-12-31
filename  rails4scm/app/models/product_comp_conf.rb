class ProductCompConf < ActiveRecord::Base
  self.table_name = "product_comp_conf"
  self.primary_key = "id"
  
  #��ѯ��ز�Ʒ
  #configure_code -- ��������
  #h_config_vers  -- �汾��
  def findProductCompConf(configure_code,h_config_vers)
    sql = "select  product_comp_conf.product_code,product_vers,active_status,h_config_vers,product_name "
    sql += "from product_comp_conf,software_product "
    sql += " where ( product_comp_conf.product_code = software_product.product_code) "
    sql += " and configure_code='" + configure_code + "'  and h_config_vers='" + h_config_vers + "' "
    
    ProductCompConf.find_by_sql(sql)
  end
  
  #��ѯ��ز�Ʒ
  #configure_code -- ��������
  #h_config_vers  -- �汾��
  def findByCodeVer(configure_code,h_config_vers)
    sql = "select PRODUCT_CODE,PRODUCT_VERS "
    sql += "from PRODUCT_COMP_CONF  "
    sql += " where CONFIGURE_CODE='"+configure_code+"' and H_CONFIG_VERS='"+h_config_vers+"' and active_status='Y'"
    ProductCompConf.find_by_sql(sql)
  end
end
