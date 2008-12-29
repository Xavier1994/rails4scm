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
 
    #����
    click_hidden = params[:click_hidden]
    if click_hidden == nil or click_hidden == "" then
      click_hidden = "0"
    end
    
    @oper = session[:operator]
    tishi = "���@W�޸�@Wɾ��@W�ɹ�!@Wʧ��@W��ֻ��ɾ�����Լ�������¼�@W���¼��Ѵ����������,���ܽ���ɾ��,����Ķ��������Ա��ϵ@W"
    @tishi = tishi.split("@W")
    @message = ""
    case click_hidden.to_i
       when 1  #���
         begin
           i =1
           event_hidden = "�Ѵ���@W������@W������@W�����@W�ر�@W"
           eventArr = event_hidden.split("@W")
           for param in params[:eventRecord]
             reco=param[i]
             addSave(eventArr,reco[:EVENT_NAME],reco[:M_EVENT_TYPE],reco[:PROJECT_CODE],@oper.NAME) 
           end
           @message=@tishi[0] + @tishi[3]
         rescue Exception => e
           @message=@tishi[0] + @tishi[4]
         end
         
       when 2  #�޸�
         begin
           k =1
           for re in params[:record]
             reco=re[k]
             eventRe = EventRecord.find(reco[:ID])
             eventRe.id=reco[:ID]
             eventRe.EVENT_NAME=reco[:EVENT_NAME]
             eventRe.M_EVENT_TYPE=reco[:M_EVENT_TYPE]
             eventRe.PROJECT_CODE=reco[:PROJECT_CODE]
             eventRe.save
           end
           @message=@tishi[1] + @tishi[3]
         rescue Exception => e
           @message=@tishi[1] + @tishi[4]
         end
       when 3  #ɾ��
         begin
           delete_ID_hidden = params[:delete_ID_hidden]
           eventRe = EventRecord.find(delete_ID_hidden)
           if(eventRe.EVENT_SPONSOR == @oper.NAME)
             configCount = ConfigureChgApp.find(:all,:conditions =>["event_code =? ",eventRe.EVENT_CODE])
             if(configCount.size>0)
               @message=@tishi[6]
             else
               eventRe.id=delete_ID_hidden
               eventRe.delete(delete_ID_hidden)
               @message=@tishi[2] + @tishi[3]
             end
             
           else
              @message=@tishi[5] + eventRe.EVENT_SPONSOR + "---" + @oper.NAME
           end
         rescue Exception => e
           @message=@tishi[2] + @tishi[4]
         end
    end
    
    #��ѯ
    @eventRecord = getData(pageSize,curPageSize,@event_name,@m_event_type,@project_code,@event_sponsor,@current_status)
    @project     = getProject()
    @eveType     = getEveType()
    
    @quarters_validate = OperatorWorks.new.quarters_validate(@oper.OPER_ID,"E1")
  end
   
  private
     #��ѯ
     def getData(pageSize,curPageSize,event_name,m_event_type,project_code,event_sponsor,current_status)
       eventRecord = EventRecord.new
       eventR = eventRecord.findEventRecordAll(pageSize,curPageSize,event_name,m_event_type,project_code,event_sponsor,current_status) 
       return eventR
     end
     
     #��ѯ���е���Ŀ
     def getProject()
       projectMsg = ProjectMsg.new()
       return projectMsg.findProjectMsgAll()
     end
     
     #��ѯ���е��¼���ʶ����
     def getEveType()
       param = Param.new()
       return param.findTypeAll("eve_type")
     end
     
     #���
     def addSave(eventArr,event_name_t,m_event_type_t,project_code_t,person)  
       #��ѯ���ID 
       argument = Argument.new
       num = 1
       eventmaxid     = argument.event_max_id(num,"EVENT_RECORD")
       num = 5
       configuremaxid = argument.max_id(num,"CONFIGURE_MSG_CYCLE_DET")
       
       eventRecord = EventRecord.new
       eventRecord.ID=eventmaxid[1]
       eventRecord.EVENT_CODE=eventmaxid[0]
       eventRecord.EVENT_NAME=event_name_t
       eventRecord.M_EVENT_TYPE=m_event_type_t
       eventRecord.PROJECT_CODE=project_code_t
       eventRecord.CURRENT_STATUS="�Ѵ���"
       eventRecord.EVENT_SPONSOR=person
       eventRecord.EVENT_TIME=Time.now
       eventRecord.save
       
       for i in (0..4)
            configureMsgCycleDetCon = ConfigureMsgCycleDet.new
            j = configuremaxid[i]
            configureMsgCycleDetCon.id            = j[0]
            configureMsgCycleDetCon.ID            = j[0]
            configureMsgCycleDetCon.EVENT_CODE    = eventmaxid[0]
            configureMsgCycleDetCon.EVENT_STATE   = eventArr[i.to_i]
            configureMsgCycleDetCon.ACTIVE_STATUS = '0'
            
            configureMsgCycleDetCon.save
       end

     end

     #ɾ��
     def deleteID(id)
       eventRecord = EventRecord.new
       eventRecord.deleteId(id)
     end
end
