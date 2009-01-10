class Scm::Event::Query::EventExecuteController < ApplicationController

  def index
    @event_code = params[:event_code]
    confChgReprojectProjects = ConfChgReprojectProjects.new
    @confChgReprojectProjects = confChgReprojectProjects.findConfChgReprojectProjects(@event_code)
    statue = "已标识@W未标识@W"
    @statue = statue.split("@W")
  end
end
