class Scm::Event::Query::EventExecuteController < ApplicationController

  def index
    @event_code = params[:event_code]
    confChgReprojectProjects = ConfChgReprojectProjects.new
    @confChgReprojectProjects = confChgReprojectProjects.findConfChgReprojectProjects(@event_code)
    statue = "�ѱ�ʶ@Wδ��ʶ@W"
    @statue = statue.split("@W")
  end
end
