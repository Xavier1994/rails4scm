class Scm::Item::Change::ItemCycleController < ApplicationController

  def index
    @configure_chg_no= params[:configure_chg_no]
    blockDefs = "�����������@WITEM_CYCLE_DIV@Wtrue@Wͬ��������Ϣ@WCONFIG_ITEM_DIV@Wfalse@W"
    @blockDefs = blockDefs.split("@W")
  end
end
