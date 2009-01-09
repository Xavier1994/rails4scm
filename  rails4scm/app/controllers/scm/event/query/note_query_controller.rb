require 'util/util'
class Scm::Event::Query::NoteQueryController < ApplicationController

  def index
    @xuanze = params[:xuanze]   #按产品查询还是按项目查询
    @danxuan = params[:danxuan] #按时间段查询还是按天数
    @checkpp = params[:checkpp]     #关联产品
    @tianshu = params[:tianshu] #固定天数
    qi = params[:DATA1] #起始时间
    if(qi != nil)
      @qi=qi[:data1]
    end
    jie = params[:DATA2] #结束时间
    if(jie != nil)
      @jie=jie[:data2] #结束时间
    end
    @code=params[:guanlian_code] #产品或者项目编号
    curPageSize = params[:page]
    pageSize = 22   
    @msg = getMsg(@xuanze)
    if(curPageSize == nil || curPageSize == "")
      flag=params[:flag] #提取是否是第一点击该菜单
      if(flag != "1")
        click_hidden=params[:click_hidden]
        if(click_hidden == "1") #点击的是查询按钮
          @eventRecord = getEvent(pageSize,curPageSize,@danxuan,@qi,@jie,@tianshu,@checkpp,@code)
        end
        if(click_hidden == "2") #点击的产品或者项目
          @eventRecord = getEventPp(pageSize,curPageSize,@code)

          @danxuan = nil
          @checkpp = nil
          @tianshu = nil
          @qi = nil
          @jie = nil
        end
      end
      session[:xuanze_session]  = @xuanze
      session[:danxuan_session] = @danxuan
      session[:checkpp_session] = @checkpp
      session[:tianshu_session] = @tianshu
      session[:qi_session]      = @qi
      session[:jie_session]     = @jie
      session[:code_session]    = @code
    else
      @xuanze  = session[:xuanze_session]
      @danxuan = session[:danxuan_session]
      @checkpp = session[:checkpp_session]
      @tianshu = session[:tianshu_session]
      @qi      = session[:qi_session]      
      @jie     = session[:jie_session]
      @code    = session[:code_session]
      
      @eventRecord = getEvent(pageSize,curPageSize,@danxuan,@qi,@jie,@tianshu,@checkpp,@code)
    end
  end
  
  #下拉选择框改变
  def change
    vl = params[:vlu]
    if(vl == "1")
      sql = "select distinct project_code code,project_name name from project_msg where project_code in (select project_code from event_record)"
      @msg = ProjectMsg.find_by_sql(sql) 
    end
    if(vl == "2")
      sql = "select distinct product_code code,product_name name from software_product where product_code in (select project_code from event_record)"
      @msg = SoftwareProduct.find_by_sql(sql)
    end
    
    texthtml = ""
    if(@msg != nil)
      util = Util.new
      j =1
      texthtml += "<table align=\"center\" cellpadding=0 cellspacing=0 border=0 style=\"width:100%;bordercolor:#878787 ;border-left-style: solid; border-left-width: 1px; border-right-style: solid; border-right-width: 1px\">"
      for msg in @msg
      texthtml += "<tr>"
      texthtml += "<td onmouseover=\"show(this,'msg" + j.to_s + "_1_2','msg" + j.to_s + "_1_1')\" onmouseout=\"hide('msg" + j.to_s + "_1_2','msg" + j.to_s + "_1_1')\">"
      texthtml += "<font id=\"msg" + j.to_s + "_1_1\">"
      texthtml += "<a style=\"cursor:hand;text-decoration:underline; color:#0066ff\" onclick=\"clickPpje('" + msg.code + "')\">" + util.intercept(msg.name,0,10) + "</a>"
      texthtml += "</font>"
      texthtml += "<div id=\"msg" + j.to_s + "_1_2\" style=\"background-color:#EFEFEF;VISIBILITY:hidden;WIDTH:100%;POSITION:absolute\" onmouseover=\"show(this,'msg" + j.to_s + "_1_2','msg" + j.to_s + "_1_1')\" onmouseout=\"hide('msg" + j.to_s + "_1_2','msg" + j.to_s + "_1_1')\">"
      texthtml += "<a style=\"cursor:hand;text-decoration:underline; color:#0066ff\" onclick=\"clickPpje('" + msg.code + "')\">" + msg.name + "</a>"
      texthtml += "</div>"
      
      texthtml += "<td>"
      texthtml += "</tr>"
      j += 1
      end
      texthtml += "</table>"
    end
    if(texthtml == nil || texthtml == "")
      texthtml = "&nbsp;"
    end
    render_text texthtml 
  end
  
 private 
   #查询产品或者项目
   def getMsg(xuanze)
     msg = nil
     if(xuanze == "1")
       sql = "select distinct project_code code,project_name name from project_msg where project_code in (select project_code from event_record)"
       msg = ProjectMsg.find_by_sql(sql)
     end
     if(xuanze == "2")
       sql = "select distinct product_code code,product_name name from software_product where product_code in (select project_code from event_record)"
       msg = SoftwareProduct.find_by_sql(sql)
     end
     
     return msg
   end
   
   #查询相关事件[点击查询按钮]
   def getEvent(pageSize,curPageSize,danxuan,qi,jie,tianshu,checkpp,code)
     where = ""
     if(danxuan == "1")
       qi = qi.lstrip
       qi = qi.rstrip
       where = "EVENT_RECORD.event_time>='"+ qi + "' and EVENT_RECORD.event_time<='" + jie + "'"
     end
     
     if(danxuan == "2")
       date = DateTime.now
       date = date -tianshu.to_i
       util = Util.new
       date = util.formatDatatimeToSting(date)
       where = "EVENT_RECORD.event_time>='" + date + "'"
     end
     
     if(where == "" || where == nil)
       if(checkpp == "1" && code != nil && code != "")
        where += " EVENT_RECORD.project_code = '" + code + "'"
       end
     else
       if(checkpp == "1" && code != nil && code != "")
        where += " and EVENT_RECORD.project_code = '" + code + "'"
       end
     end
     
     sql = "SELECT EVENT_RECORD.ID,EVENT_RECORD.EVENT_CODE,"
     sql += "EVENT_RECORD.EVENT_NAME,EVENT_RECORD.M_EVENT_TYPE,"   
     sql += "EVENT_RECORD.PROJECT_CODE,EVENT_RECORD.CURRENT_STATUS,"
     sql += "EVENT_RECORD.EVENT_SPONSOR,EVENT_RECORD.EVENT_TIME "
     sql += " FROM EVENT_RECORD "
     if(where != nil && where != "")
      sql += " where " + where
     end
     sql += " order by ID desc"
     
     return EventRecord.paginate_by_sql([sql],:per_page =>pageSize,:page =>curPageSize,:order=>"ID desc")
   end
   
   #选中产品或者项目查询出相关的事件
   def getEventPp(pageSize,curPageSize,code)
     sql = "SELECT EVENT_RECORD.ID,EVENT_RECORD.EVENT_CODE,"
     sql += "EVENT_RECORD.EVENT_NAME,EVENT_RECORD.M_EVENT_TYPE,"   
     sql += "EVENT_RECORD.PROJECT_CODE,EVENT_RECORD.CURRENT_STATUS,"
     sql += "EVENT_RECORD.EVENT_SPONSOR,EVENT_RECORD.EVENT_TIME "
     sql += " FROM EVENT_RECORD "
     sql +=  " where EVENT_RECORD.project_code = '" + code + "'"
     sql += " order by ID desc"
     
     return EventRecord.paginate_by_sql([sql],:per_page =>pageSize,:page =>curPageSize,:order=>"ID desc")
   end
end
