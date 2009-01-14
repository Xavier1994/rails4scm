require 'util/util'
class Scm::Event::Note::EventCycleTwoController < ApplicationController

  def index
    @message = ""
    @event_code = params[:event_code]
    queding_hidden = params[:event_chg_hidden]
    @oper = session[:operator]
    event_state = "已创建@W待评估@W决策中@W变更中@W关闭@W已关闭@W"
    @eventArr = event_state.split("@W")
    
    eventRecord = EventRecord.new
    configureMsgCycleDet = ConfigureMsgCycleDet.new
    @eventRecord = eventRecord.findEventRecor(@event_code)
    @configureMsgCycleDetYi = configureMsgCycleDet.findConfigureMsgCycleDet(@event_code,@eventArr[2])
    @configureMsgCycleDetEr = configureMsgCycleDet.findConfigureMsgCycleDet(@event_code,@eventArr[3])
    @configureMsgCycleDetSa = configureMsgCycleDet.findConfigureMsgCycleDet(@event_code,@eventArr[4])
    @quarters_validate = validate_two(@eventRecord.CURRENT_STATUS,@oper.OPER_ID)
    @message = ""
    #tijiao = "提交@W状态数据成功!@W状态数据失败!@W保存@W可能还有项目没有通知到，事件还不能关闭@W可能还有变更没有完成，事件还不能关闭@W更改状态成功!@W"
    tijiao = "提交@W状态数据成功!@W状态数据失败!@W保存@W可能还有变更没有完成，事件还不能关闭@W可能还有变更没有完成，事件还不能关闭@W更改状态成功!@W"
    tijiaoArr = tijiao.split("@W")
    
    #更改状态
    if(queding_hidden.to_s == "3")
      current_stat = params[:current_stat]
      param = Param.find(:first,:conditions =>["PARAM_CLASS='eve_stat' and PARAM_CODE =?",current_stat])
      @eventRecord.id = @eventRecord.ID
      @eventRecord.CURRENT_STATUS = param.PARAM_NAME 
      @eventRecord.save
      @message = tijiaoArr[6]
      @eventRecord = eventRecord.findEventRecor(@event_code)
    end
    
    #保存[确定按钮]
    if(queding_hidden == "1")
      event_prsn01  = params[:EVENT_PRSN01]
      dt = params[:DATA]
      date_01 = dt[:data1]
      event_prsn02  = params[:EVENT_PRSN02]
      date_02       = Time.now
      conclusion_01 = params[:CONCLUSION_01]
      conclusion_02 = params[:CONCLUSION_02]
      work_days01   = params[:WORK_DAYS01]
      work_days02   = params[:WORK_DAYS02]
      remark_01     = params[:REMARK_01]
      remark_02     = params[:REMARK_02]
      remark_03     = params[:REMARK_03]
      
      case @quarters_validate[0]
         when "C"
           #决策中
           begin
             event_prsn02  = @oper.NAME
             date_02       = Time.now
             
             @configureMsgCycleDetYi.EVENT_PRSN01=event_prsn01
             @configureMsgCycleDetYi.DATE_01     =date_01
             @configureMsgCycleDetYi.EVENT_PRSN02=event_prsn02
             @configureMsgCycleDetYi.DATE_02     =date_02
             @configureMsgCycleDetYi.REMARK_01   =remark_01
             @configureMsgCycleDetYi.REMARK_02   =remark_02
             @configureMsgCycleDetYi.REMARK_03   =remark_03
             @configureMsgCycleDetYi.CONCLUSION_01=conclusion_01
             @configureMsgCycleDetYi.CONCLUSION_02=conclusion_02
             @configureMsgCycleDetYi.WORK_DAYS01=work_days01
             @configureMsgCycleDetYi.WORK_DAYS02=work_days02

             @configureMsgCycleDetYi.id = @configureMsgCycleDetYi.ID
             @configureMsgCycleDetYi.save
             @message = tijiaoArr[3] + @eventArr[2] + tijiaoArr[1]
           rescue Exception => e
             @message = tijiaoArr[3] + @eventArr[2] + tijiaoArr[2]
           end
         when "D"
           #变更中
           begin
             event_prsn02  = @oper.NAME
             date_02       = Time.now

             @configureMsgCycleDetEr.EVENT_PRSN01=event_prsn01
             @configureMsgCycleDetEr.DATE_01     =date_01
             @configureMsgCycleDetEr.EVENT_PRSN02=event_prsn02
             @configureMsgCycleDetEr.DATE_02     =date_02
             @configureMsgCycleDetEr.REMARK_01   =remark_01
             @configureMsgCycleDetEr.REMARK_02   =remark_02
             @configureMsgCycleDetEr.REMARK_03   =remark_03
             @configureMsgCycleDetEr.CONCLUSION_01=conclusion_01
             @configureMsgCycleDetEr.CONCLUSION_02=conclusion_02
             @configureMsgCycleDetEr.WORK_DAYS01=work_days01
             @configureMsgCycleDetEr.WORK_DAYS02=work_days02

             @configureMsgCycleDetEr.id = @configureMsgCycleDetEr.ID
             @configureMsgCycleDetEr.save
             
             @message = tijiaoArr[3] + @eventArr[3] + tijiaoArr[1]
            
           rescue Exception => e
             @message = tijiaoArr[3] + @eventArr[3] + tijiaoArr[2]
           end
          when "E"
           #关闭
           begin
             event_prsn02  = @oper.NAME
             date_02       = Time.now

             @configureMsgCycleDetSa.EVENT_PRSN01=event_prsn01
             @configureMsgCycleDetSa.DATE_01     =date_01
             @configureMsgCycleDetSa.EVENT_PRSN02=event_prsn02
             @configureMsgCycleDetSa.DATE_02     =date_02
             @configureMsgCycleDetSa.REMARK_01   =remark_01
             @configureMsgCycleDetSa.REMARK_02   =remark_02
             @configureMsgCycleDetSa.REMARK_03   =remark_03
             @configureMsgCycleDetSa.CONCLUSION_01=conclusion_01
             @configureMsgCycleDetSa.CONCLUSION_02=conclusion_02
             @configureMsgCycleDetSa.WORK_DAYS01=work_days01
             @configureMsgCycleDetSa.WORK_DAYS02=work_days02

             @configureMsgCycleDetSa.id = @configureMsgCycleDetSa.ID
             @configureMsgCycleDetSa.save
             
             @message = tijiaoArr[3] + @eventArr[4] + tijiaoArr[1]
            
           rescue Exception => e
             @message = tijiaoArr[3] + @eventArr[4] + tijiaoArr[2]
           end
      end
    end
    
    #提交
    if(queding_hidden == "2")
      @eventRecord.id = @eventRecord.ID
      event_prsn01  = params[:EVENT_PRSN01]
      dt = params[:DATA]
      date_01 = dt[:data1]
      event_prsn02  = params[:EVENT_PRSN02]
      date_02       = Time.now
      conclusion_01 = params[:CONCLUSION_01]
      conclusion_02 = params[:CONCLUSION_02]
      work_days01   = params[:WORK_DAYS01]
      work_days02   = params[:WORK_DAYS02]
      remark_01     = params[:REMARK_01]
      remark_02     = params[:REMARK_02]
      remark_03     = params[:REMARK_03]
      
      case @quarters_validate[0]
         when "C"
           #决策中
           begin
             event_prsn02  = @oper.NAME
             date_02       = Time.now
             EventRecord.transaction do
               @configureMsgCycleDetYi.EVENT_PRSN01=event_prsn01
               @configureMsgCycleDetYi.DATE_01     =date_01
               @configureMsgCycleDetYi.EVENT_PRSN02=event_prsn02
               @configureMsgCycleDetYi.DATE_02     =date_02
               @configureMsgCycleDetYi.REMARK_01   =remark_01
               @configureMsgCycleDetYi.REMARK_02   =remark_02
               @configureMsgCycleDetYi.REMARK_03   =remark_03
               @configureMsgCycleDetYi.CONCLUSION_01=conclusion_01
               @configureMsgCycleDetYi.CONCLUSION_02=conclusion_02
               @configureMsgCycleDetYi.WORK_DAYS01=work_days01
               @configureMsgCycleDetYi.WORK_DAYS02=work_days02

               @configureMsgCycleDetYi.id = @configureMsgCycleDetYi.ID
               @configureMsgCycleDetYi.save

               @eventRecord.CURRENT_STATUS = @eventArr[3]
               @eventRecord.save
               @message = tijiaoArr[0] + @eventArr[3] + tijiaoArr[1]
             end
           rescue Exception => e
             @message = tijiaoArr[0] + @eventArr[3] + tijiaoArr[2]
           end
         when "D"
           #变更中
           begin
             event_prsn02  = @oper.NAME
             date_02       = Time.now
             EventRecord.transaction do
               @configureMsgCycleDetEr.EVENT_PRSN01=event_prsn01
               @configureMsgCycleDetEr.DATE_01     =date_01
               @configureMsgCycleDetEr.EVENT_PRSN02=event_prsn02
               @configureMsgCycleDetEr.DATE_02     =date_02
               @configureMsgCycleDetEr.REMARK_01   =remark_01
               @configureMsgCycleDetEr.REMARK_02   =remark_02
               @configureMsgCycleDetEr.REMARK_03   =remark_03
               @configureMsgCycleDetEr.CONCLUSION_01=conclusion_01
               @configureMsgCycleDetEr.CONCLUSION_02=conclusion_02
               @configureMsgCycleDetEr.WORK_DAYS01=work_days01
               @configureMsgCycleDetEr.WORK_DAYS02=work_days02

               @configureMsgCycleDetEr.id = @configureMsgCycleDetEr.ID
               @configureMsgCycleDetEr.save

               @eventRecord.CURRENT_STATUS = @eventArr[4]
               @eventRecord.save
               @message = tijiaoArr[0] + @eventArr[4] + tijiaoArr[1]
             end
           rescue Exception => e
             @message = tijiaoArr[0] + @eventArr[4] + tijiaoArr[2]
           end
         when "E"
           #关闭
           begin
             event_prsn02  = @oper.NAME
             date_02       = Time.now
             EventRecord.transaction do
               @configureMsgCycleDetSa.EVENT_PRSN01=event_prsn01
               @configureMsgCycleDetSa.DATE_01     =date_01
               @configureMsgCycleDetSa.EVENT_PRSN02=event_prsn02
               @configureMsgCycleDetSa.DATE_02     =date_02
               @configureMsgCycleDetSa.REMARK_01   =remark_01
               @configureMsgCycleDetSa.REMARK_02   =remark_02
               @configureMsgCycleDetSa.REMARK_03   =remark_03
               @configureMsgCycleDetSa.CONCLUSION_01=conclusion_01
               @configureMsgCycleDetSa.CONCLUSION_02=conclusion_02
               @configureMsgCycleDetSa.WORK_DAYS01=work_days01
               @configureMsgCycleDetSa.WORK_DAYS02=work_days02

               @configureMsgCycleDetSa.id = @configureMsgCycleDetSa.ID
               @configureMsgCycleDetSa.save

               #所有的项目已经结束
               confChgReprojectProjects = ConfChgReprojectProjects.new
               cProject = confChgReprojectProjects.findConfChgReprojectProjects(@event_code)
               if(cProject.size>0)
                 @message = tijiaoArr[4]
                 return ""
               end
               #判断所有的变更是否完成
               cus = "关闭@W"
               cusArra = cus.split("@W")
               configureChgApp = ConfigureChgApp.new
               cChg = configureChgApp.findConfigureChgAppStaute(@event_code,cusArra[0])
               if(cChg.size>0) then
                 @message = tijiaoArr[5]
                 return ""
               end
               @eventRecord.CURRENT_STATUS = @eventArr[5]
               @eventRecord.save
               @message = tijiaoArr[0] + @eventArr[4] + tijiaoArr[1]
             end
           rescue Exception => e
             @message = tijiaoArr[0] + @eventArr[4] + tijiaoArr[2]
           end
      end
    end
    
    @eventRecord = eventRecord.findEventRecor(@event_code)
    @quarters_validate = validate_two(@eventRecord.CURRENT_STATUS,@oper.OPER_ID)
    
    @date_01_Yi = ""
    @date_02_Yi = ""
    @date_01_Er = ""
    @date_02_Er = ""
    @date_01_Sa = ""
    @date_02_Sa = ""
    util = Util.new
    if(@configureMsgCycleDetYi.DATE_01 == nil) then
      #@date_01_Yi = (Time.now).strftime('%Y-%m-%d')
      @date_01_Yi = util.formatDatatimeToSting(Time.now)
    else
      #@date_01_Yi = ((@configureMsgCycleDetYi.DATE_01).to_datetime).strftime('%Y-%m-%d')
      @date_01_Yi = util.formatDatatimeToSting(@configureMsgCycleDetYi.DATE_01)
    end
    if(@configureMsgCycleDetYi.DATE_02 == nil) then
      @date_02_Yi = util.formatDatatimeToSting(Time.now)
    else
      @date_02_Yi = util.formatDatatimeToSting(@configureMsgCycleDetYi.DATE_02)
    end
    if(@configureMsgCycleDetEr.DATE_01 == nil) then
      @date_01_Er = util.formatDatatimeToSting(Time.now)
    else
      @date_01_Er = util.formatDatatimeToSting(@configureMsgCycleDetEr.DATE_01)
    end
    if(@configureMsgCycleDetEr.DATE_02 == nil) then
      @date_02_Er = util.formatDatatimeToSting(Time.now)
    else
      @date_02_Er = util.formatDatatimeToSting(@configureMsgCycleDetEr.DATE_02)
    end
    if(@configureMsgCycleDetSa.DATE_01 == nil) then
      @date_01_Sa = util.formatDatatimeToSting(Time.now)
    else
      @date_01_Sa = util.formatDatatimeToSting(@configureMsgCycleDetSa.DATE_01)
    end
    if(@configureMsgCycleDetSa.DATE_02 == nil) then
      @date_02_Sa = util.formatDatatimeToSting(Time.now)
    else
      @date_02_Sa = util.formatDatatimeToSting(@configureMsgCycleDetSa.DATE_02)
    end
  end
  
  def chang
    eventRecord = EventRecord.new
    @event_code = params[:event_code]
    msg = "变更申请触发完成!@W事件不在决策中状态,不能触发变更申请,请提交到决策中状态!@W变更申请触发失败!@W没有变更申请需求@W"
    @msg = msg.split("@W")
    begin

    @eventRecord = eventRecord.findEventRecor(@event_code)
    if @eventRecord != nil then 
        text = "决策中A@W"
        textArray = text.split("A@W")
        if(@eventRecord.CURRENT_STATUS == textArray[0]) then
          re = RelaChgConfigure.new
          @re = re.findRelaChgConfigure(@event_code)
          if(@re.size >0) then
            configureChgApp = ConfigureChgApp.new
            argument = Argument.new
            configureVersion = ConfigureVersion.new
            configureChgCycleDet = ConfigureChgCycleDet.new
            text = "已创建@W已实现@W已批准@W执行@W检出-变更@W"
            textArray = text.split("@W")
            max_id = argument.max_id(@re.size, "CONFIGURE_CHG_APP")
            i = 0
            ConfigureChgApp.transaction do
              for re in (@re)
                @configureChgApp=configureChgApp.findCount(@event_code, re.CONFIGURE_CODE,re.CONFIGURE_VERS)
                if(@configureChgApp.size == 0)
                  configureChgApp.inserinto(max_id[i],max_id[i],re.CONFIGURE_CODE,@event_code,@eventRecord.EVENT_NAME,re.CONFIGURE_VERS,@eventRecord.PROJECT_CODE,textArray[0])
                  configureVersion.updateConfigureVersion(re.CONFIGURE_CODE,re.CONFIGURE_VERS,textArray[4], Time.now,@eventRecord.PROJECT_CODE)

                  #生成变更生命周期
                  max_id_cn = argument.max_id(4, "CONFIGURE_CHG_CYCLE_DET")
                  configureChgCycleDet.insertConfigureChgCycleDet(max_id_cn[0],max_id[i],textArray[0],"0")
                  configureChgCycleDet.insertConfigureChgCycleDet(max_id_cn[1],max_id[i],textArray[1],"0")
                  configureChgCycleDet.insertConfigureChgCycleDet(max_id_cn[2],max_id[i],textArray[2],"0")
                  configureChgCycleDet.insertConfigureChgCycleDet(max_id_cn[3],max_id[i],textArray[3],"0")
                end
                i = i + 1
              end
            end
            @message = @msg[0]
          else
            @message = @msg[3]
          end
        else
          @message = @msg[1]
        end
        
    end
    rescue Exception => e
       print e.backtrace.join("\n")
       @message = @msg[2]
    end
    if(@message == nil)
      @message = ""
    end
    render_text @message
  end
  
private
   def validate_two(cur_state,oper_id)
     tijiao = "提交到@W关闭事件@W"
     @tijiao = tijiao.split("@W")
     vl = Array.new(2)
     vl[0] = "" 
     vl[1] = ""
     case cur_state
        when @eventArr[0]
          quarters_validate = OperatorWorks.new.quarters_validate(oper_id,"E1")
          if(quarters_validate == 100)
            vl[0] = "A"
            vl[1] = @tijiao[0].to_s + @eventArr[1]
          end
        when @eventArr[1]
          quarters_validate = OperatorWorks.new.quarters_validate(oper_id,"E2")
          if(quarters_validate == 100)
            vl[0] = "B"
            vl[1] = @tijiao[0].to_s + @eventArr[2]
          end
        when @eventArr[2]
          quarters_validate = OperatorWorks.new.quarters_validate(oper_id,"E3")
          if(quarters_validate == 100)
            vl[0] = "C"
            vl[1] = @tijiao[0].to_s + @eventArr[3]
          end
        when @eventArr[3]
          quarters_validate = OperatorWorks.new.quarters_validate(oper_id,"E4")
          if(quarters_validate == 100)
            vl[0] = "D"
            vl[1] = @tijiao[0].to_s + @eventArr[4]
          end
        when @eventArr[4]
          quarters_validate = OperatorWorks.new.quarters_validate(@oper.OPER_ID,"E5")
          if(quarters_validate == 100)
            vl[0] = "E"
            vl[1] = @tijiao[1].to_s
          end
        when @eventArr[5]
          quarters_validate = OperatorWorks.new.quarters_validate(@oper.OPER_ID,"E5")
          if(quarters_validate == 100)
            vl[0] = "F"
            vl[1] = "提交"
          end
     end
     return vl
   end
end
