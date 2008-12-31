require 'util/util'
class Scm::Item::Query::ItemCycleOneController < ApplicationController

  def index
    @configure_chg_no = params[:configure_chg_no]
    queding_hidden = params[:click_hidden]
    @configurechg = ConfigureChgApp.find(@configure_chg_no)
    @oper = session[:operator]
    configure_state = "已创建@W已实现@W已批准@W执行@W关闭@W"
    @configure_state = configure_state.split("@W")
    
    configureChgCycleDet = ConfigureChgCycleDet.new
    @configureChgCycleDetYi = configureChgCycleDet.findConfigureChgCycleDet(@configure_chg_no,@configure_state[0])
    @configureChgCycleDetEr = configureChgCycleDet.findConfigureChgCycleDet(@configure_chg_no,@configure_state[1])
    @configureChgCycleDetSa = configureChgCycleDet.findConfigureChgCycleDet(@configure_chg_no,@configure_state[2])
    @configureChgCycleDetSi = configureChgCycleDet.findConfigureChgCycleDet(@configure_chg_no,@configure_state[3])
    if(@configureChgCycleDetYi.CHG_PRSN01 == nil )
      @configureChgCycleDetYi.CHG_PRSN01 = @oper.NAME
    end
    if(@configureChgCycleDetEr.CHG_PRSN01 == nil )
      @configureChgCycleDetEr.CHG_PRSN01 = @oper.NAME
    end
    if(@configureChgCycleDetSa.CHG_PRSN01 == nil )
      @configureChgCycleDetSa.CHG_PRSN01 = @oper.NAME
    end
    if(@configureChgCycleDetSi.CHG_PRSN01 == nil )
      @configureChgCycleDetSi.CHG_PRSN01 = @oper.NAME
    end
    
    @quarters_validate = validate(@configurechg.CURRENT_STATUS,@oper.OPER_ID)
    tijiao = "提交@W状态数据成功!@W状态数据失败!@W保存@W更改状态成功!@W您还没有确定后版本号，请先确定后版本号@W此版本已生成,您的后版本号可能不是最新@W执行成功@W"
    tijiaoArr = tijiao.split("@W")
    
    #更改状态
    if(queding_hidden.to_s == "3")
      current_stat = params[:current_stat]
      @configurechg.id = @configurechg.ID
      @configurechg.CURRENT_STATUS = current_stat
      @configurechg.save
      @message = tijiaoArr[4]
    end
    
    #保存[确定按钮]
    if(queding_hidden == "1")
      chg_prsn01  = @oper.NAME
      chg_date01  = Time.now
      chg_prsn02  = params[:CHG_PRSN02]
      chg_date02  = nil
      work_days = params[:WORK_DAYS]
      remark = params[:REMARK]
      
      case @quarters_validate[0]
         when "A"
           #已创建
           begin
             @configureChgCycleDetYi.CHG_PRSN01=chg_prsn01
             @configureChgCycleDetYi.CHG_DATE01=chg_date01
             @configureChgCycleDetYi.CHG_PRSN02=chg_prsn02
             @configureChgCycleDetYi.CHG_DATE02=chg_date02
             @configureChgCycleDetYi.WORK_DAYS =work_days
             @configureChgCycleDetYi.REMARK    =remark

             @configureChgCycleDetYi.id = @configureChgCycleDetYi.ID
             @configureChgCycleDetYi.save
             @message = tijiaoArr[3] + @configure_state[0] + tijiaoArr[1]
           rescue Exception => e
             @message = tijiaoArr[3] + @configure_state[0] + tijiaoArr[2]
           end
         when "B"
           #已实现
           begin
             for date_0102 in params[:DATA]
                dt = date_0102[1]
                chg_date02 = dt[:data2]
            end
             @configureChgCycleDetEr.CHG_PRSN01=chg_prsn01
             @configureChgCycleDetEr.CHG_DATE01=chg_date01
             @configureChgCycleDetEr.CHG_PRSN02=chg_prsn02
             @configureChgCycleDetEr.CHG_DATE02=chg_date02
             @configureChgCycleDetEr.WORK_DAYS =work_days
             @configureChgCycleDetEr.REMARK    =remark

             @configureChgCycleDetEr.id = @configureChgCycleDetEr.ID
             @configureChgCycleDetEr.save
             
             @message = tijiaoArr[3] + @configure_state[1] + tijiaoArr[1]
            
           rescue Exception => e
             @message = tijiaoArr[3] + @configure_state[1] + tijiaoArr[2]
           end
          when "C"
           #已批准
           begin
             @configureChgCycleDetSa.CHG_PRSN01=chg_prsn01
             @configureChgCycleDetSa.CHG_DATE01=chg_date01
             @configureChgCycleDetSa.CHG_PRSN02=chg_prsn02
             @configureChgCycleDetSa.CHG_DATE02=chg_date02
             @configureChgCycleDetSa.WORK_DAYS =work_days
             @configureChgCycleDetSa.REMARK    =remark

             @configureChgCycleDetSa.id = @configureChgCycleDetSa.ID
             @configureChgCycleDetSa.save
             
             @message = tijiaoArr[3] + @configure_state[2] + tijiaoArr[1]
            
           rescue Exception => e
             @message = tijiaoArr[3] + @configure_state[2] + tijiaoArr[2]
           end
           
        when "D"
           #执行
           begin
             @configureChgCycleDetSi.CHG_PRSN01=chg_prsn01
             @configureChgCycleDetSi.CHG_DATE01=chg_date01
             @configureChgCycleDetSi.CHG_PRSN02=chg_prsn02
             @configureChgCycleDetSi.CHG_DATE02=chg_date02
             @configureChgCycleDetSi.WORK_DAYS =work_days
             @configureChgCycleDetSi.REMARK    =remark

             @configureChgCycleDetSi.id = @configureChgCycleDetSi.ID
             @configureChgCycleDetSi.save
             
             @message = tijiaoArr[3] + @configure_state[3] + tijiaoArr[1]
            
           rescue Exception => e
             @message = tijiaoArr[3] + @configure_state[3] + tijiaoArr[2]
           end
      end
    end
    
    #提交
    if(queding_hidden == "2")
      @configurechg.id = @configurechg.ID
      
      case @quarters_validate[0]
         when "A"
           #已创建
           begin
             @configurechg.CURRENT_STATUS = @configure_state[1]
             
             @configurechg.save
             @message = tijiaoArr[0] + @configure_state[1] + tijiaoArr[1]
           rescue Exception => e
             @message = tijiaoArr[0] + @configure_state[1] + tijiaoArr[2]
           end
         when "B"
           #已实现
           begin
             @configurechg.CURRENT_STATUS = @configure_state[2]
             
             @configurechg.save
             @message = tijiaoArr[0] + @configure_state[2] + tijiaoArr[1]
           rescue Exception => e
             @message = tijiaoArr[0] + @configure_state[2] + tijiaoArr[2]
           end
         when "C"
           #已批准
           begin
             @configurechg.CURRENT_STATUS = @configure_state[3]
             
             @configurechg.save
             @message = tijiaoArr[0] + @configure_state[3] + tijiaoArr[1]
           rescue Exception => e
             @message = tijiaoArr[0] + @configure_state[3] + tijiaoArr[2]
           end
           
        when "D"
           #执行
           begin
             @configurechg.CURRENT_STATUS = @configure_state[4]
             @configurechg.save
             
             st = "受控@W"
             str = st.split("@W")
             configureVers = ConfigureVers.find(:first,:conditions =>["configure_code=? and configure_vers=?",@configurechg.CONFIGURE_CODE,@configurechg.PRE_VERSION])
             configureVers.CUR_STATE=str[0]
             configureVers.save
             
             @message = tijiaoArr[0] + @configure_state[4] + tijiaoArr[1]
           rescue Exception => e
             @message = tijiaoArr[0] + @configure_state[4] + tijiaoArr[2]
           end
      end
    end
    
    #执行
    if(queding_hidden == "4")
      aft_version = @configurechg.AFT_VERSION
      if(aft_version == nil || aft_version == "")
        @message = tijiaoArr[5]
      else
        
        #configure = ConfigureVers.findConfigureVers(@configurechg.CONFIGURE_CODE,@configurechg.AFT_VERSION)
        configure = ConfigureVers.find(:all,:conditions =>["configure_code=? and configure_vers=?",@configurechg.CONFIGURE_CODE,@configurechg.AFT_VERSION])
        if(configure.size>0)
          @message = tijiaoArr[6]
        else
          argument = Argument.new
          num = 1
          maxid = argument.max_id(num,"CONFIGURE_VERSION")
          for j in (maxid)
            st = "受控@W"
            str = st.split("@W")
            conf = ConfigureVers.new
            conf.ID=j[0]
            conf.id=j[0]
            conf.CONFIGURE_CODE=@configurechg.CONFIGURE_CODE
            conf.CONFIGURE_VERS=@configurechg.AFT_VERSION
            conf.CUR_STATE=str[0]
            conf.STATE_DATE=Time.now
            conf.VER_RELEASE=nil
            conf.COMMENT=@configurechg.CONFIGURE_CHG_NO
            conf.save
            
            @message = tijiaoArr[7]
          end
        end
      end
    end
    
    @configurechg = ConfigureChgApp.find(@configure_chg_no)
    @quarters_validate = validate(@configurechg.CURRENT_STATUS,@oper.OPER_ID)   
    
    @chg_date01_Yi = ""
    @chg_date01_Yi = ""
    @chg_date01_Er = ""
    @chg_date01_Er = ""
    @chg_date01_Sa = ""
    @chg_date01_Sa = ""
    @chg_date01_Si = ""
    @chg_date01_Si = ""
    util = Util.new
    if(@configureChgCycleDetYi.CHG_DATE01 == nil) then
      @chg_date01_Yi = util.formatDatatimeToSting(Time.now)
    else
      @chg_date01_Yi = util.formatDatatimeToSting(@configureChgCycleDetYi.CHG_DATE01)
    end
    if(@configureChgCycleDetYi.CHG_DATE02 == nil) then
      @chg_date01_Yi = util.formatDatatimeToSting(Time.now)
    else
      @chg_date01_Yi = util.formatDatatimeToSting(@configureChgCycleDetYi.CHG_DATE02)
    end
    if(@configureChgCycleDetEr.CHG_DATE01 == nil) then
      @chg_date01_Er = util.formatDatatimeToSting(Time.now)
    else
      @chg_date01_Er = util.formatDatatimeToSting(@configureChgCycleDetEr.CHG_DATE01)
    end
    if(@configureChgCycleDetEr.CHG_DATE02 == nil) then
      @chg_date01_Er = util.formatDatatimeToSting(Time.now)
    else
      @chg_date01_Er = util.formatDatatimeToSting(@configureChgCycleDetEr.CHG_DATE02)
    end
    if(@configureChgCycleDetSa.CHG_DATE01 == nil) then
      @chg_date01_Sa = util.formatDatatimeToSting(Time.now)
    else
      @chg_date01_Sa = util.formatDatatimeToSting(@configureChgCycleDetSa.CHG_DATE01)
    end
    if(@configureChgCycleDetSa.CHG_DATE02 == nil) then
      @chg_date01_Sa = util.formatDatatimeToSting(Time.now)
    else
      @chg_date01_Sa = util.formatDatatimeToSting(@configureChgCycleDetSa.CHG_DATE02)
    end
    if(@configureChgCycleDetSi.CHG_DATE01 == nil) then
      @chg_date01_Si = util.formatDatatimeToSting(Time.now)
    else
      @chg_date01_Si = util.formatDatatimeToSting(@configureChgCycleDetSi.CHG_DATE01)
    end
    if(@configureChgCycleDetSi.CHG_DATE02 == nil) then
      @chg_date01_Si = util.formatDatatimeToSting(Time.now)
    else
      @chg_date01_Si = util.formatDatatimeToSting(@configureChgCycleDetSi.CHG_DATE02)
    end
  end
 
 private
   def validate(cur_state,oper_id)
     tijiao = "提交到@W关闭事件@W"
     @tijiao = tijiao.split("@W")
     vl = Array.new(2)
     vl[0] = "" 
     vl[1] = ""
     case cur_state
        when @configure_state[0]
          quarters_validate = OperatorWorks.new.quarters_validate(oper_id,"C1")
          if(quarters_validate == 100)
            vl[0] = "A"
            vl[1] = @tijiao[0].to_s + @configure_state[1]
          end
        when @configure_state[1]
          quarters_validate = OperatorWorks.new.quarters_validate(oper_id,"C2")
          if(quarters_validate == 100)
            vl[0] = "B"
            vl[1] = @tijiao[0].to_s + @configure_state[2]
          end
        when @configure_state[2]
          quarters_validate = OperatorWorks.new.quarters_validate(oper_id,"C3")
          if(quarters_validate == 100)
            vl[0] = "C"
            vl[1] = @tijiao[0].to_s + @configure_state[3]
          end
        when @configure_state[3]
          quarters_validate = OperatorWorks.new.quarters_validate(oper_id,"C4")
          if(quarters_validate == 100)
            vl[0] = "D"
            vl[1] = @tijiao[0].to_s + @configure_state[4]
          end
        when @configure_state[4]
          quarters_validate = OperatorWorks.new.quarters_validate(oper_id,"C4")
          if(quarters_validate == 100)
            vl[0] = "E"
            vl[1] = @tijiao[0].to_s
          end
     end
     return vl
   end
end
