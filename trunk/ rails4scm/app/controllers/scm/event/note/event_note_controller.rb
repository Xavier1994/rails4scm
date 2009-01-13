class Scm::Event::Note::EventNoteController < ApplicationController

  def index
    curPageSize = params[:page]
    pageSize = 22
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
    click_hidden = params[:click_hidden]
    if click_hidden == nil or click_hidden == "" then
      click_hidden = "0"
    end
    
    #保存
    @oper = session[:operator]
    tishi = "保存@W修改@W删除@W成功!@W失败!@W您只能删除你自己发起的事件@W该事件已触发变更申请,不能进行删除,如需改动请与管理员联系@W事件状态修改@W"
    @tishi = tishi.split("@W")
    event_hidden = "已创建@W待评估@W决策中@W变更中@W关闭@W已关闭@W"
    eventArr = event_hidden.split("@W")
    @message = ""
    case click_hidden.to_i
       when 1  #添加
          hash = params[:eventRecord].to_a
          errcount = 0
          for param in hash
           reco=param[1]
           au = 0
           begin
             cnid = reco[:ID]
             if(cnid == nil || cnid == "")
               au = 2
             else
               au = 1
             end
           rescue Exception => e
             au = 2
           end
 
           if(au == 1)
             begin
               if (reco.key?(:EVENT_NAME))
                 eventRe = EventRecord.find(reco[:ID])
                 if(eventRe.CURRENT_STATUS == eventArr[5])
                   continue
                 end
                 eventRe.id=reco[:ID]
                 eventRe.EVENT_NAME=reco[:EVENT_NAME]
                 eventRe.M_EVENT_TYPE=reco[:M_EVENT_TYPE]
                 eventRe.PROJECT_CODE=reco[:PROJECT_CODE]
                 eventRe.save
               end
             rescue Exception => e
               @message=@tishi[0] + @tishi[4]
               errcount += 1
             end
           else
             begin
               addSave(eventArr,reco[:EVENT_NAME],reco[:M_EVENT_TYPE],reco[:PROJECT_CODE],@oper.NAME)
             rescue Exception => e
               @message=@tishi[0] + @tishi[4]
               errcount += 1
             end
           end
          end
          if(errcount > 0)
            @message=@tishi[0] + @tishi[3]
          end
       when 3  #删除
         begin
           delete_ID_hidden = params[:delete_ID_hidden]
           eventRe = EventRecord.find(delete_ID_hidden)
           if(eventRe.EVENT_SPONSOR == @oper.NAME)
             configCount = ConfigureChgApp.find(:all,:conditions =>["event_code =? ",eventRe.EVENT_CODE])
             if(configCount.size>0)
               @message=@tishi[6]
             else
               msg_cycle=ConfigureMsgCycleDet.find(:all,:conditions =>["event_code =? ",eventRe.EVENT_CODE])
               for msg in msg_cycle
                 ConfigureMsgCycleDet.delete(msg.ID)
               end
               EventRecord.delete(delete_ID_hidden)
               @message=@tishi[2] + @tishi[3]
             end
             
           else
              @message=@tishi[5] + eventRe.EVENT_SPONSOR + "---" + @oper.NAME
           end
         rescue Exception => e
           @message=@tishi[2] + @tishi[4]
         end
     when 4  #状态回溯
         begin
           event_no     = params[:delete_ID_hidden]
           current_stat = params[:current_stat]
           eventRecord = EventRecord.find(event_no)
           eventRecord.id = event_no
           eventRecord.CURRENT_STATUS = current_stat
           eventRecord.save
           @message=@tishi[7] + @tishi[3]
         rescue Exception => e
           @message=@tishi[7] + @tishi[4]
         end
    end
    
    #查询
    @eventRecord = getData(pageSize,curPageSize,@event_name,@m_event_type,@project_code,@event_sponsor,@current_status)
    @project     = getProject()
    @eveType     = getEveType()
    
    @quarters_validate = OperatorWorks.new.quarters_validate(@oper.OPER_ID,"E1")
  end
  
  def chang
    event_code = params[:event_code]
    cn = params[:cn]
    event = EventRecord.find(:first,:conditions =>["event_code =?",event_code])
    if(event != nil)
      text = cn + "@W" + event.CURRENT_STATUS
      render :text=> text
    else
      render :text=> ""
    end
  end
  
  def statute
    text = "事件状态修改成功@W事件状态修改失败@W"
    textArray = text.split("@W")
    text = ""
    begin
       event_no     = params[:id]
       current_stat = params[:current_stat]
       cn = params[:cn]
       param = Param.find(:first,:conditions =>["PARAM_CLASS='eve_stat' and PARAM_CODE =?",current_stat])
       eventRecord = EventRecord.find(event_no)
       eventRecord.id = event_no
       eventRecord.CURRENT_STATUS = param.PARAM_NAME
       eventRecord.save
       text = cn + "@W" + param.PARAM_NAME + "@W" + textArray[0]
    rescue Exception => e
       text = "@W@W" + textArray[1]
    end
    render :text=> text
  end
  
  private
     #查询
     def getData(pageSize,curPageSize,event_name,m_event_type,project_code,event_sponsor,current_status)
       eventRecord = EventRecord.new
       eventR = eventRecord.findEventRecordAll(pageSize,curPageSize,event_name,m_event_type,project_code,event_sponsor,current_status) 
       return eventR
     end
     
     #查询所有的项目
     def getProject()
       projectMsg = ProjectMsg.new()
       return projectMsg.findProjectMsgAll()
     end
     
     #查询所有的事件标识类型
     def getEveType()
       param = Param.new()
       return param.findTypeAll("eve_type")
     end
     
     #添加
     def addSave(eventArr,event_name_t,m_event_type_t,project_code_t,person)  
       #查询最大ID 
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
       eventRecord.CURRENT_STATUS="已创建"
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

     #删除
     def deleteID(id)
       eventRecord = EventRecord.new
       eventRecord.deleteId(id)
     end
end
