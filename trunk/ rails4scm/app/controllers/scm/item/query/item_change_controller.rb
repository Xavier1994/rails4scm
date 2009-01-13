class Scm::Item::Query::ItemChangeController < ApplicationController

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
    click_hidden = params[:click_hidden]
    if click_hidden == nil or click_hidden == "" then
      click_hidden = "0"
    end
    
    @oper = session[:operator]
    tishi = "保存@W状态回溯@W成功!@W失败@W作废@W"
    @tishi = tishi.split("@W")
    @message = ""
    case click_hidden.to_i
       when 1  #修改
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
         
       when 2  #状态回溯
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
      when 3  #状态作废
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
    
    #查询
    @configure = getData(pageSize,curPageSize,@configure_code,@configure_name,@event_name,@project_code,@current_status)
    @project     = getProject()
  end
  
  def chang
    configure_code = params[:configure_code]
    cn = params[:cn]
    conf = ConfigureChgApp.find(:first,:conditions =>["configure_chg_no =? ",configure_code])
    text = ""
    if(conf != nil)
      text = cn + "@W" + conf.CURRENT_STATUS
      
    end
    render :text=> text
  end
  
  def statute
    text = "状态回溯成功@W状态回溯失败@W"
    textArray = text.split("@W")
    text = ""
    begin
       id     = params[:id]
       current_stat = params[:current_stat]
       cn = params[:cn]
       param = Param.find(:first,:conditions =>["PARAM_CLASS='con_stat2' and PARAM_CODE =?",current_stat])
       conf = ConfigureChgApp.find(id)
       conf.id= conf.ID
       conf.CURRENT_STATUS=param.PARAM_NAME
       conf.save
       text = cn + "@W" + param.PARAM_NAME + "@W" + textArray[0]
    rescue Exception => e
       text = "@W@W" + textArray[1]
    end
    render_text text
  end
  
  def cancle
    text = "作废成功@W作废失败@W"
    textArray = text.split("@W")
    text = ""
     begin
       id = params[:id]
       cn = params[:cn]
       cur = "已$A废$A除eee$A"
       curA = cur.split("$A")
       conf = ConfigureChgApp.find(id)
       conf.id= conf.ID
       conf.CURRENT_STATUS=curA[0] + curA[1] + curA[2]
       conf.save
       text = cn + "-" + textArray[0] 
     rescue Exception => e
       text = "-" + textArray[1]
     end
    render_text text
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
