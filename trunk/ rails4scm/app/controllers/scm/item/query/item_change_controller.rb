class Scm::Item::Query::ItemChangeController < ApplicationController

  def index
    curPageSize = params[:page]
    pageSize = 18
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
    click_hidden = params[:click_hidden]
    if click_hidden == nil or click_hidden == "" then
      click_hidden = "0"
    end
    
    @oper = session[:operator]
    tishi = "����@W״̬����@W�ɹ�!@Wʧ��@W����@W"
    @tishi = tishi.split("@W")
    @message = ""
    case click_hidden.to_i
       when 1  #�޸�
         begin
           i =1
           for param in params[:configure]
             reco=param[i]
             conf = ConfigureChgApp.find(reco[:ID])
             conf.id= reco[:ID]
             conf.AFT_VERSION=reco[:AFT_VERSION]
             conf.save
           end
           @message=@tishi[0] + @tishi[2]
         rescue Exception => e
           @message=@tishi[0] + @tishi[3]
         end
         
       when 2  #״̬����
         begin
           current_stat = params[:current_stat]
           configure_chg_no = params[:configure_chg_no_hidden]
           
           conf = ConfigureChgApp.find(configure_chg_no)
           conf.id= conf.ID
           conf.CURRENT_STATUS=current_stat
           conf.save
           @message=@tishi[1] + @tishi[2]
         rescue Exception => e
           @message=@tishi[1] + @tishi[3]
         end
      when 3  #״̬����
         begin
           current_stat = params[:current_stat]
           configure_chg_no = params[:configure_chg_no_hidden]
           
           conf = ConfigureChgApp.find(configure_chg_no)
           conf.id= conf.ID
           conf.CURRENT_STATUS=current_stat
           conf.save
           @message=@tishi[4] + @tishi[2]
         rescue Exception => e
           @message=@tishi[4] + @tishi[3]
         end
    end
    
    #��ѯ
    @configure = getData(pageSize,curPageSize,@configure_code,@configure_name,@event_name,@project_code,@current_status)
    @project     = getProject()
  end
  
  private
     #��ѯ���е�������
     def getData(pageSize,curPageSize,configure_code,configure_name,event_name,project_code,current_status)
       configureChgApp = ConfigureChgApp.new
       return configureChgApp.findConfigureChgAppAll(pageSize,curPageSize,configure_code,configure_name,event_name,project_code,current_status)
     end
  
     #��ѯ���е���Ŀ
     def getProject()
       projectMsg = ProjectMsg.new()
       return projectMsg.findProjectMsgAll()
     end
end
