class Scm::Event::Note::EventNoteController < ApplicationController

  def index
    curPageSize = params[:page]
    pageSize = 18
    @event_name     = params[:event_name]
    @m_event_type   = params[:m_event_type]
    @project_code   = params[:project_code]
    @event_sponsor  = params[:event_sponsor]
    @current_status = params[:current_status]
    if(@event_name == "") then
      @event_name = nil
    end
    if(@m_event_type == "") then
      @m_event_type = nil
    end
    if(@project_code == "") then
      @project_code = nil
    end
    if(@event_sponsor == "") then
      @event_sponsor = nil
    end
    if(@current_status == "") then
      @current_status = nil
    end
    if(curPageSize != nil)
      @event_name     = session[:event_name_session]
      @m_event_type   = session[:m_event_type_session]
      @project_code   = session[:project_code_session]
      @event_sponsor  = session[:event_sponsor_session]
      @current_status = session[:current_status_session]
    else
      session[:event_name_session]     = @event_name
      session[:m_event_type_session]   = @m_event_type
      session[:project_code_session]   = @project_code
      session[:event_sponsor_session]  = @event_sponsor
      session[:event_sponsor_session]  = @event_sponsor
      session[:current_status_session] = @current_status
    end
    
    #查询
    @eventRecord = getData(pageSize,curPageSize,@event_name,@m_event_type,@project_code,@event_sponsor,@current_status)
    
    #保存
    click_hidden = params[:click_hidden]
    if click_hidden == nil or click_hidden == "" then
      click_hidden = "0"
    end
    
  private
     #查询
     def getData(pageSize,curPageSize,event_name,m_event_type,project_code,event_sponsor,current_status)
       eventRecord = EventRecord.new
       event = eventRecord.findEventRecordAll(pageSize,curPageSize,@event_name,@m_event_type,@project_code,@event_sponsor,@current_status) 
       return event
     end
     
     #查询所有的项目
     def getPfroject()
       
     end
     
     #添加
     #修改
     #删除
  end
end
