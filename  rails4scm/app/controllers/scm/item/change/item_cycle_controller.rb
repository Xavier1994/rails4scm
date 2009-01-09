class Scm::Item::Change::ItemCycleController < ApplicationController

  def index
    @configure_chg_no= params[:configure_chg_no]
    blockDefs = "变更生命周期@WITEM_CYCLE_DIV@Wtrue@W同步升级信息@WCONFIG_ITEM_DIV@Wfalse@W"
    @blockDefs = blockDefs.split("@W")
  end
end
