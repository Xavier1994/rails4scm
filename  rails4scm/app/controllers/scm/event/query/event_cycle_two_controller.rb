require 'util/util'
class Scm::Event::Query::EventCycleTwoController < ApplicationController

  def index
    @event_code = params[:event_code]
    event_state = "�Ѵ���@W������@W������@W�����@W�ر�@W�ѹر�@W"
    @eventArr = event_state.split("@W")
    configureMsgCycleDet = ConfigureMsgCycleDet.new
    @eventRecord = EventRecord.find(:first,:conditions =>["event_code=? ",@event_code])
    @configureMsgCycleDetYi = configureMsgCycleDet.findConfigureMsgCycleDet(@event_code,@eventArr[2])
    @configureMsgCycleDetEr = configureMsgCycleDet.findConfigureMsgCycleDet(@event_code,@eventArr[3])
    @configureMsgCycleDetSa = configureMsgCycleDet.findConfigureMsgCycleDet(@event_code,@eventArr[4])
  end
end
