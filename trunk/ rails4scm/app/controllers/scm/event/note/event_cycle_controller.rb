
class Scm::Event::Note::EventCycleController < ApplicationController

  def index
    @event_code= params[:event_code]
    @blockDefs = Array.new 
    @blockDefs[0] = "事件生命周期"
    @blockDefs[1] = "EVENT_CYCLE_DIV"
    @blockDefs[2] = true
    @blockDefs[3] = "事件生命周期续" 
    @blockDefs[4] = "EVENT_CYCLE_XU_DIV"
    @blockDefs[5] = false
    @blockDefs[6] = "变更配置项清单" 
    @blockDefs[7] = "CONFIG_ITEM_DIV"
    @blockDefs[8] = false
  end
end
