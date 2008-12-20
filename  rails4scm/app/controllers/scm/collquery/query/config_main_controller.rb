class Scm::Collquery::Query::ConfigMainController < ApplicationController
  before_filter :fileLoginSessionNil
  
  def index
    configure_code = params[:code]
    @item = nil
    @vers = nil
    @comp = nil
    @itemOne = nil
    if configure_code != nil then
      item = ConfigureItem.new()
      comp = ConfigureCompList.new()
      vers = ConfigureVers.new()
      
      @item = item.findConfigureItemCode(configure_code)
      @comp = comp.findConfigureCompListList(configure_code)
      @vers = vers.findConfigureVersList(configure_code)
      
      for item in @item
        @itemOne = item
      end
    end
  end
end
