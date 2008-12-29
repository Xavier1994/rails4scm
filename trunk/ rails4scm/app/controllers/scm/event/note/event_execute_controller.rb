class Scm::Event::Note::EventExecuteController < ApplicationController

  def index
    @event_code = params[:event_code]
    confChgReprojectProjects = ConfChgReprojectProjects.new
    @confChgReprojectProjects = confChgReprojectProjects.findConfChgReprojectProjects(@event_code)
    statue = "已标识@W未标识@W"
    @statue = statue.split("@W")
    cl = params[:queding_hidden]
    if(cl == "1") then
      i=1
      for param in params[:conf]
        reco=param[i]
        conf = ConfChgReprojectProjects.find(reco[:ID])
        conf.id=reco[:ID]
        conf.ID=reco[:ID]
        conf.NEW_IDENTIFY_STATUS=reco[:NEW_IDENTIFY_STATUS]
        conf.NEW_STORE_STATUS=reco[:NEW_STORE_STATUS]
        conf.CHG_CIRC_STATUS= reco[:CHG_CIRC_STATUS]
        conf.CHG_CIRC_DETAIL=reco[:CHG_CIRC_DETAIL]
        
        conf.save
      end
      
      @confChgReprojectProjects = confChgReprojectProjects.findConfChgReprojectProjects(@event_code)
    end
  end
end
