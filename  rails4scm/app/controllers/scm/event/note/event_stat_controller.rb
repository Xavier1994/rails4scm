class Scm::Event::Note::EventStatController < ApplicationController

  def index
    @event_code = params[:event_code]
    eventRecord = EventRecord.new
    param = Param.new
    @eventRecord = eventRecord.findEventRecor(@event_code) 
    @param =  param.findTypeAll("eve_stat")
  end
end
