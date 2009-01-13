require 'util/util'
class Scm::Event::Note::EventCycleOneController < ApplicationController

  def index
    @event_code = params[:event_code]
    queding_hidden = params[:queding_hidden]
    @oper = session[:operator]
    event_state = "已创建@W待评估@W决策中@W变更中@W关闭@W已关闭@W"
    @eventArr = event_state.split("@W")
    
    eventRecord = EventRecord.new
    configureMsgCycleDet = ConfigureMsgCycleDet.new
    @eventRecord = eventRecord.findEventRecor(@event_code)
    @configureMsgCycleDetYi = configureMsgCycleDet.findConfigureMsgCycleDet(@event_code,@eventArr[0])
    @configureMsgCycleDetEr = configureMsgCycleDet.findConfigureMsgCycleDet(@event_code,@eventArr[1])
    @quarters_validate =  validate(@eventRecord.CURRENT_STATUS,@oper.OPER_ID)
    @message = ""
    tijiao = "提交@W状态数据成功!@W状态数据失败!@W保存@W更改状态成功!@W"
    tijiaoArr = tijiao.split("@W")
    
    #更改状态
    if(queding_hidden.to_s == "3")
      current_stat = params[:current_stat]
      param = Param.find(:first,:conditions =>["PARAM_CLASS='eve_stat' and PARAM_CODE =?",current_stat])
      @eventRecord.id = @eventRecord.ID
      @eventRecord.CURRENT_STATUS = param.PARAM_NAME
      @eventRecord.save
      @message = tijiaoArr[4]
      @eventRecord = eventRecord.findEventRecor(@event_code)
    end
    
    #保存[确定按钮]
    if(queding_hidden == "1")
      event_prsn01  = params[:EVENT_PRSN01]
      date_01       = Time.now
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
         when "A"
           #已创建
           begin
             event_prsn01  = @oper.NAME
             date_01       = Time.now
             dt = params[:DATA]
             date_02 = dt[:data2]
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
             @message = tijiaoArr[3] + @eventArr[0] + tijiaoArr[1]
           rescue Exception => e
             @message = tijiaoArr[3] + @eventArr[0] + tijiaoArr[2]
           end
         when "B"
           #待评估
           begin
             event_prsn02  = @oper.NAME
             date_02       = Time.now
             dt = params[:DATA]
             date_01 = dt[:data1]
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
             
             @message = tijiaoArr[3] + @eventArr[1] + tijiaoArr[1]
           rescue Exception => e
             @message = tijiaoArr[3] + @eventArr[1] + tijiaoArr[2]
           end
      end
    end
    
    #提交
    if(queding_hidden == "2")
      @eventRecord.id = @eventRecord.ID
      event_prsn01  = params[:EVENT_PRSN01]
      date_01       = Time.now
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
         when "A"
           #已创建
           begin
             event_prsn01  = @oper.NAME
             date_01       = Time.now
             dt = params[:DATA]
             date_02 = dt[:data2]
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
             
             @eventRecord.CURRENT_STATUS = @eventArr[1]
             @eventRecord.save
             @message = tijiaoArr[0] + @eventArr[1] + tijiaoArr[1]
           rescue Exception => e
             @message = tijiaoArr[0] + @eventArr[1] + tijiaoArr[2]
           end
         when "B"
           #待评估
           begin
             event_prsn02  = @oper.NAME
             date_02       = Time.now
             dt = params[:DATA]
             date_01 = dt[:data1]
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
             
             @eventRecord.CURRENT_STATUS = @eventArr[2]
             @eventRecord.save
             @message = tijiaoArr[0] + @eventArr[2] + tijiaoArr[1]
           rescue Exception => e
             @message = tijiaoArr[0] + @eventArr[2] + tijiaoArr[2]
           end
      end
    end
    
    @quarters_validate =  validate(@eventRecord.CURRENT_STATUS,@oper.OPER_ID)
    
    @date_01_Yi = ""
    @date_02_Yi = ""
    @date_01_Er = ""
    @date_02_Er = ""
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
  end
  
private 
   def validate(cur_state,oper_id)
     vl = Array.new(2)
     case cur_state
        when @eventArr[0]
          quarters_validate = OperatorWorks.new.quarters_validate(oper_id,"E1")
          if(quarters_validate == 100)
            vl[0] = "A"
            vl[1] = @eventArr[1]
          end
        when @eventArr[1]
          quarters_validate = OperatorWorks.new.quarters_validate(oper_id,"E2")
          if(quarters_validate == 100)
            vl[0] = "B"
            vl[1] = @eventArr[2]
          end
        when @eventArr[2]
          quarters_validate = OperatorWorks.new.quarters_validate(oper_id,"E3")
          if(quarters_validate == 100)
            vl[0] = "C"
            vl[1] = ""
          end
        when @eventArr[3]
          quarters_validate = OperatorWorks.new.quarters_validate(oper_id,"E4")
          if(quarters_validate == 100)
            vl[0] = "D"
            vl[1] = @eventArr[4]
          end
        when @eventArr[4]
          quarters_validate = OperatorWorks.new.quarters_validate(@oper.OPER_ID,"E5")
          if(quarters_validate == 100)
            vl[0] = "E"
            vl[1] = ""
          end
        when @eventArr[5]
          quarters_validate = OperatorWorks.new.quarters_validate(@oper.OPER_ID,"E5")
          if(quarters_validate == 100)
            vl[0] = "F"
            vl[1] = ""
          end
     end
     return vl
   end
end
