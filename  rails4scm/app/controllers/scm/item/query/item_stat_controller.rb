class Scm::Item::Query::ItemStatController < ApplicationController

  def index
    @configure_chg_no = params[:configure_chg_no]
    confChg = ConfigureChgApp.new
    param = Param.new
    @configure = confChg.findConfigureChgApp_no(@configure_chg_no) 
    @param =  param.findTypeAll("con_stat2")
  end
end
