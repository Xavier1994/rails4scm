class Scm::Collquery::Query::ConfigProductController < ApplicationController
  before_filter :fileLoginSessionNil
  
  #��ѯ��ز�Ʒ
  def index
      configure_code = params[:code]
      h_config_vers =  params[:h_config_vers]
      
      product = ProductCompConf.new()
      @product = product.findProductCompConf(configure_code, h_config_vers)
  end
end
