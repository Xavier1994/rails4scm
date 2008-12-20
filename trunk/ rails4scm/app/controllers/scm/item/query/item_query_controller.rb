require 'fs_tabpanel'
class Scm::Item::Query::ItemQueryController < ApplicationController

 def index
    curPageSize = params[:page]
    pageSize = 18
    @blockDefs = Array.new 
    @blockDefs[0] = "变更"
    @blockDefs[1] = "table_requests"
    @blockDefs[2] = false
    @blockDefs[3] = "周期"
    @blockDefs[4] = "cycle"
    @blockDefs[5] = true
    @blockDefs[6] = "同步"
    @blockDefs[7] = "info_Promotion"
    @blockDefs[8] = false
   
    #@conf = conf.list()
    @conf = conf_list(pageSize,curPageSize)
  end
  
private  
 def conf_list(pageSize,curPageSize)
    conf = ConfigureChgApp.new()
    return conf.list(pageSize, curPageSize)
  end  
end
