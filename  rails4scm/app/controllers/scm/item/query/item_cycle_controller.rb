class Scm::Item::Query::ItemCycleController < ApplicationController

  def index
    @event_code= params[:event_code]
    blockDefs = "变更生命周期@WITEM_CYCLE_DIV@Wtrue@W同步升级信息@WCONFIG_ITEM_DIV@Wfalse@W"
    @blockDefs = blockDefs.split("@W")
  end
end
