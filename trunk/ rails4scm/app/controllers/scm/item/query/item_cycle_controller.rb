class Scm::Item::Query::ItemCycleController < ApplicationController

  def index
    @event_code= params[:event_code]
    blockDefs = "�����������@WITEM_CYCLE_DIV@Wtrue@Wͬ��������Ϣ@WCONFIG_ITEM_DIV@Wfalse@W"
    @blockDefs = blockDefs.split("@W")
  end
end
