require 'util/util'
class Scm::Event::Query::EventCycleTwoController < ApplicationController

  def index
    @event_code = params[:event_code]
    event_state = "已创建@W待评估@W决策中@W变更中@W关闭@W已关闭@W"
    @eventArr = event_state.split("@W")
    configureMsgCycleDet = ConfigureMsgCycleDet.new
    @eventRecord = EventRecord.find(:first,:conditions =>["event_code=? ",@event_code])
    @configureMsgCycleDetYi = configureMsgCycleDet.findConfigureMsgCycleDet(@event_code,@eventArr[2])
    @configureMsgCycleDetEr = configureMsgCycleDet.findConfigureMsgCycleDet(@event_code,@eventArr[3])
    @configureMsgCycleDetSa = configureMsgCycleDet.findConfigureMsgCycleDet(@event_code,@eventArr[4])
  end
end
