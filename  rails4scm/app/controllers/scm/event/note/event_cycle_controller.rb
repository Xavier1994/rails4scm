
class Scm::Event::Note::EventCycleController < ApplicationController

  def index
    @event_code= params[:event_code]
    @blockDefs = Array.new 
    @blockDefs[0] = "�¼���������"
    @blockDefs[1] = "EVENT_CYCLE_DIV"
    @blockDefs[2] = true
    @blockDefs[3] = "�¼�����������" 
    @blockDefs[4] = "EVENT_CYCLE_XU_DIV"
    @blockDefs[5] = false
    @blockDefs[6] = "����������嵥" 
    @blockDefs[7] = "CONFIG_ITEM_DIV"
    @blockDefs[8] = false
  end
end
