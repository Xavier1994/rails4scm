class Scm::Item::Change::ItemQueryController < ApplicationController

  def index
    curPageSize = params[:page]
    pageSize = 22
    @configure_code = params[:configure_code]
    @configure_name = params[:configure_name]
    @event_name     = params[:event_name]
    @project_code   = params[:project_code]
    @current_status = params[:current_status]
    if(curPageSize != nil)
      @configure_code = session[:configure_code_session]
      @configure_name = session[:configure_name_session]
      @event_name     = session[:event_name_session]
      @project_code   = session[:project_code_session]
      @current_status = session[:current_status_session]
    else
      session[:configure_code_session] = @configure_code 
      session[:configure_name_session] = @configure_name
      session[:event_name_session]     = @event_name
      session[:project_code_session]   = @project_code
      session[:current_status_session] = @current_status
    end
    
    #查询
    @configure = getData(pageSize,curPageSize,@configure_code,@configure_name,@event_name,@project_code,@current_status)
    @project     = getProject()
  end
  
  private
     #查询所有的配置项
     def getData(pageSize,curPageSize,configure_code,configure_name,event_name,project_code,current_status)
       configureChgApp = ConfigureChgApp.new
       return configureChgApp.findConfigureChgAppAll(pageSize,curPageSize,configure_code,configure_name,event_name,project_code,current_status)
     end
  
     #查询所有的项目
     def getProject()
       projectMsg = ProjectMsg.new()
       return projectMsg.findProjectMsgAll()
     end
end
