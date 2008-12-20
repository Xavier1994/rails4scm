class Scm::Collquery::Query::ConfigQueryController < ApplicationController
  before_filter :fileLoginSessionNil
  
  def index
    @blockDefs = Array.new 
    @blockDefs[0] = "配置项基本信息"
    @blockDefs[1] = "CONFIG_BASE_DIV"
    @blockDefs[2] = true
    @blockDefs[3] = "配置项查询" 
    @blockDefs[4] = "CONFIG_QUERY_DIV"
    @blockDefs[5] = false
  end
  
end
