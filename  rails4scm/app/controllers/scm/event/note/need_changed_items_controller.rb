class Scm::Event::Note::NeedChangedItemsController < ApplicationController

  def index
    @event_code=params[:event_code]
  end
  
  def addItem
    textreturn="出现异常，请与系统管理员联系!@|"
    textreturnArray=textreturn.split("@|")
    configure_params=params[:configure_params]
    event_code=params[:event_code]
    textTemp="@@@@@@已存在变更申请,配置项:@W版本为:@W"
    textArray=textTemp.split("@W")
    outText="<table cellpadding=0 cellspacing=0 border=0 style=\"width:100%;bordercolo:#878787 ;border-left-style: solid; border-left-width: 0px; border-right-style: solid; border-right-width: 0px\"><thead class=\"td_header_bak2\"><tr><td class=\"td_header_bak2\" width=\"50px\">选择<input type=\"hidden\" name=\"param_configure_code\" id=\"param_configure_code\"></td><td class=\"td_header_bak3\" width=\"160px\">配置项名称</td><td class=\"td_header_bak3\" width=\"70px\">配置项版本</td><td class=\"td_header_bak3\" width=\"80px\">配置项编号</td><td class=\"td_header_bak3\" width=\"80px\">事件编号</td><td class=\"td_header_bak3\" width=\"120px\">操作</td></tr></thead><tbody>"
    @selectedItems=nil
    b=true
    begin
    if event_code!=nil then 
      if configure_params!=nil then
        configure_params=Iconv.iconv("GB2312","UTF-8",configure_params).to_s
        configureParamsArray=configure_params.split("@")
        relaChgConfigure0=RelaChgConfigure.new
        if configureParamsArray[0]!=nil && configureParamsArray[2]!=nil then
          itemNum=relaChgConfigure0.findEventConfigItemNum(event_code, configureParamsArray[0], configureParamsArray[2])
          if itemNum[0].cn<=0 then
            #向rela_chg_configure表插入一条记录
            argument = Argument.new
            num = 1
            maxid = argument.max_id(num,"rela_chg_configure")
            j = maxid[0]
            relaChgConfigure=RelaChgConfigure.new
            relaChgConfigure.ID=j[0]
            relaChgConfigure.EVENT_CODE=event_code
            relaChgConfigure.CONFIGURE_CODE=configureParamsArray[0]
            relaChgConfigure.CONFIGURE_VERS=configureParamsArray[2]
            relaChgConfigure.M_CONFIG_FLAG=nil
            relaChgConfigure.save
          
            productCompConf0=ProductCompConf.new
            productCompConfs=productCompConf0.findByCodeVer(configureParamsArray[0], configureParamsArray[2])
            productcompcodeArray=Array.new
            productcompversArray=Array.new
            k=0
            if productCompConfs!=nil && productCompConfs.size>0 then
              for productcompconf in productCompConfs
                productcompcodeArray[k]=productcompconf.PRODUCT_CODE
                productcompversArray[k]=productcompconf.PRODUCT_VERS
                k+=1
              end
            end
            #向CONF_CHG_REPRODUCT_PRODUCTS表插入num条记录
            num = productCompConfs.size
            maxid = argument.max_id(num,"CONF_CHG_REPRODUCT_PRODUCTS")
            k=0
            for i in maxid
              confChgReproductProducts=ConfChgReproductProducts.new
              confChgReproductProducts.ID=i[0]
              confChgReproductProducts.EVENT_CODE=event_code
              confChgReproductProducts.CONFIGURE_CODE=configureParamsArray[0]
              confChgReproductProducts.CONFIGURE_VERS=configureParamsArray[2]
              confChgReproductProducts.PRODUCT_CODE=productcompcodeArray[k]
              confChgReproductProducts.PRODUCT_VERS=productcompversArray[k]
              confChgReproductProducts.CAN_USE_FLAG="0"
              confChgReproductProducts.save
              k+=1
            end
          
            prjConRela0=PrjConRela.new
            prjConRelas=prjConRela0.findCode(configureParamsArray[0], configureParamsArray[2])
            prjconrelacodeArray=Array.new
            k=0
            if prjConRelas!=nil && prjConRelas.size>0 then
              for prjConRela in prjConRelas
                prjconrelacodeArray[k]=prjConRela.PRODUCT_CODE
                k+=1
              end
            end
            #向PRJ_CON_RELA表插入num条记录
            num = prjConRelas.size
            maxid = argument.max_id(num,"PRJ_CON_RELA")
            k=0
            for i in maxid
              prjConRela=PrjConRela.new
              prjConRela.ID=i[0]
              prjConRela.EVENT_CODE=event_code
              prjConRela.CONFIGURE_CODE=configureParamsArray[0]
              prjConRela.CONFIGURE_VERS=configureParamsArray[2]
              prjConRela.PROJECT_CODE=prjconrelacodeArray[k]
              prjConRela.CAN_USE_FLAG="0"
              prjConRela.save
              k+=1
            end
          else
            outText=textArray[0]+configureParamsArray[1].to_s+textArray[1]+configureParamsArray[2].to_s
            b=false
          end
        end
      end
        if b==false then
        else
          configureItem=ConfigureItem.new
          configureItems=configureItem.findEventConfigureItemSelected(event_code)
          if configureItems!=nil && configureItems.size>0 then
            projectproductOperateText="相关项目及产品|@"
            projectproductOperateArray=projectproductOperateText.split("|@")
            for configureitem in configureItems
              outText+="<tr>"
              outText+="<td class='td6' width='50px'>&nbsp;<input type=\"checkbox\" name=\""+configureitem.CONFIGURE_CODE+"@"+configureitem.CONFIGURE_VERS+"\" onclick=\"selectdelete(this)\" value=\""+configureitem.CONFIGURE_CODE+"@"+configureitem.CONFIGURE_VERS+"\"></td>"
              outText+="<td class='td7' width='160px'>&nbsp;"+configureitem.CONFIGURE_NAME+"</td>"
              outText+="<td class='td7' width='70px'>&nbsp;"+configureitem.CONFIGURE_VERS+"</td>"
              outText+="<td class='td7' width='80px'>&nbsp;"+configureitem.CONFIGURE_CODE+"</td>"
              outText+="<td class='td7' width='80px'>&nbsp;"+configureitem.EVENT_CODE+"</td>"
              outText+="<td class='td7' width='120px'>&nbsp;<a href='#' onclick=\"changeProjectProduct('"+configureitem.CONFIGURE_CODE+"@"+configureitem.CONFIGURE_VERS+"')\">"+projectproductOperateArray[0].to_s+"</a></td>"
              outText+="</tr>"
            end
          end
          outText+="</tbody></table>"
        end
    end
    rescue Exception => e  
      outText=textreturnArray[0]
      render_text outText
             puts(e.to_s)
             print e.backtrace.join("[删除配置项异常--(/scm/event/note/need_changed_items_controller)]\n")
    end
    render_text outText
  end
  
  def deleteItem
    textreturn="出现异常，请与系统管理员联系!@|"
    textreturnArray=textreturn.split("@|")
    configure_params=params[:configure_params]
    event_code=params[:event_code]
    outText=""
    begin
    if event_code!=nil then 
      message = "待评估@W0@@你是否确定要删除配置项:@W的变更请求?@W1@W2@@该事件状态发生变化，已不能直接删除，请与管理员联系!@W3@@该事件已出发变更，不能直接删除，请与管理员联系!@W"
      messageArray = message.split("@W")
      if configure_params!=nil then
        configure_params=Iconv.iconv("GB2312","UTF-8",configure_params).to_s
        configureParamsArray=configure_params.split("@")
        relaChgConfigure0=RelaChgConfigure.new
        
        if configureParamsArray[0]!=nil && configureParamsArray[1]!=nil then
          itemNum=relaChgConfigure0.findEventAppConfigItemNum(event_code, configureParamsArray[0], configureParamsArray[1])
          if itemNum[0].cn<=0 then
            eventRecord=EventRecord.new
            events=eventRecord.findEventRecor(event_code)
            if events!=nil then
              status=""             
              status=events.CURRENT_STATUS
              if status==messageArray[0] then
                outText=messageArray[1]+configureParamsArray[0].to_s+messageArray[2]
              else
                outText=messageArray[3]
              end
            else
              outText=messageArray[4]
            end
          else
            outText=outText=messageArray[5]
          end
        end
      end
    end
    rescue Exception => e  
             outText=textreturnArray[0]
             render_text outText
             puts(e.to_s)
             print e.backtrace.join("[删除配置项异常--(/scm/event/note/need_changed_items_controller)]\n")
    end
    render_text outText
  end
  
  def changeProjectProduct
    textreturn="出现异常，请与系统管理员联系!@|"
    textreturnArray=textreturn.split("@|")
    configure_params=params[:configure_params]
    event_code=params[:event_code]
    outText=""
    if event_code!=nil then 
      if configure_params!=nil then
        configure_params=Iconv.iconv("GB2312","UTF-8",configure_params).to_s
        configureParamsArray=configure_params.split("@")
        if configureParamsArray[0]!=nil && configureParamsArray[1]!=nil then
          outText="<table cellpadding=0 cellspacing=0 border=0 style=\"height:100%;bordercolo:#878787 ;border-left-style: solid; border-left-width: 1px; border-right-style: solid; border-right-width: 1px\"><tr><td valign=\"top\"><div style=\"overflow-x:auto;overflow-y:auto\"> <table cellpadding=0 cellspacing=0 border=0 style=\"width:100%;bordercolo:#878787 ;border-left-style: solid; border-left-width: 1px; border-right-style: solid; border-right-width: 1px\"><thead class=\"td_header_bak2\"><tr><td class=\"td_header_bak2\" width=\"150px\">项目名称</td><td class=\"td_header_bak3\" width=\"100px\">配置项升级后使用标志</td><td class=\"td_header_bak3\" width=\"80px\">项目编号</td></tr></thead><tbody><form name='projectform'>"
          confChgReproductProducts=ConfChgReproductProducts.new
          confChgReprojectProjects=ConfChgReprojectProjects.new
          begin
          projectList=confChgReprojectProjects.findByEvencodeConfcodeConfver(event_code, configureParamsArray[0], configureParamsArray[1])
          productList=confChgReproductProducts.findByEvencodeConfcodeConfver(event_code, configureParamsArray[0], configureParamsArray[1])
          projectattributenames=""
          if projectList!=nil && projectList.size>0 then
            for project in projectList
              projectattributenames+project.CID.to_s+"@"
              outText+="<tr>"
              outText+="<td class='td6' width='150px'>&nbsp;"+project.PROJECT_NAME+"</td>"
              if project.CAN_USE_FLAG.to_s=="11" then
                outText+="<td class='td7' width='100px'>&nbsp;<input type='checkbox' name='project"+project.CID.to_s+"' id='project"+project.CID.to_s+"'  checked value='"+project.CID.to_s+"'></td>"
              elsif project.CAN_USE_FLAG.to_s=="00" then
                outText+="<td class='td7' width='100px'>&nbsp;<input type='checkbox' name='project"+project.CID.to_s+"' id='project"+project.CID.to_s+"'  value='"+project.CID.to_s+"'></td>"
              else
                outText+="<td class='td7' width='100px'>&nbsp;not 11 or 00</td>"
              end
              outText+="<td class='td7' width='80px'>&nbsp;"+project.PROJECT_CODE+"<input type=\"hidden\" name=\"project_event_code\" value=\""+project.EVENT_CODE+"\">"+"<input type=\"hidden\" name=\"project_configure_code\" value=\""+project.CONFIGURE_CODE+"\">"+"<input type=\"hidden\" name=\"project_configure_vers\" value=\""+project.CONFIGURE_VERS+"\">"+"<input type=\"hidden\" name=\"project_id\" value=\""+project.ID.to_s+"\"></td>"
              outText+="</tr>"
              outText+="<input type='hidden' name='projectattribute'  value='"+projectattributenames.to_s+"'>"
            end
          end
          outText+="<input type='hidden' name='projectattribute'  value='"+projectattributenames.to_s+"'>"
          outText+="</form></tbody></table></div></td><td valign=\"top\"><div style=\"overflow-x:auto;overflow-y:auto\"><table cellpadding=0 cellspacing=0 border=0 style=\"width:100%;bordercolo:#878787 ;border-left-style: solid; border-left-width: 1px; border-right-style: solid; border-right-width: 1px\"><thead class=\"td_header_bak2\"><tr><td class=\"td_header_bak2\" width=\"150px\">产品名称</td><td class=\"td_header_bak3\" width=\"80px\">配置项升级后是否适用</td><td class=\"td_header_bak3\" width=\"80px\">产品版本</td><td class=\"td_header_bak3\" width=\"80px\">产品编号</td></tr></thead><tbody><form name='productform'>"
          productattributenames=""
          if productList!=nil && productList.size>0 then
            for product in productList
              productattributenames+=product.CID.to_s+"@"
              outText+="<tr>"
              outText+="<td class='td6' width='150px'>&nbsp;"+product.PRODUCT_NAME+"</td>"
              if product.CAN_USE_FLAG.to_s=="11" then
                outText+="<td class='td7' width='100px'>&nbsp;<input type='checkbox' name='product"+product.CID.to_s+"' id='product"+product.CID.to_s+"'  checked value='"+product.CID.to_s+"'></td>"
              elsif product.CAN_USE_FLAG.to_s=="00" then
                outText+="<td class='td7' width='100px'>&nbsp;<input type='checkbox' name='product"+product.CID.to_s+"' id='product"+product.CID.to_s+"'  value='"+product.CID.to_s+"'></td>"
              else
                outText+="<td class='td7' width='100px'>&nbsp;not 11 or 00</td>"
              end
              outText+="<td class='td7' width='80px'>&nbsp;"+product.PRODUCT_VERS+"</td>"
              outText+="<td class='td7' width='80px'>&nbsp;"+product.PRODUCT_CODE+"<input type=\"hidden\" name=\"product_event_code\" value=\""+product.EVENT_CODE+"\">"+"<input type=\"hidden\" name=\"product_configure_code\" value=\""+product.CONFIGURE_CODE+"\">"+"<input type=\"hidden\" name=\"product_configure_vers\" value=\""+product.CONFIGURE_VERS+"\">"+"<input type=\"hidden\" name=\"product_id\" value=\""+product.ID.to_s+"\">"+"</td>"
              outText+="</tr>"
            end
            
          end
          rescue Exception => e 
             outText=textreturnArray[0]
             render_text outText            
             puts(e.to_s)
             print e.backtrace.join("[删除配置项异常--(/scm/event/note/need_changed_items_controller)]\n")
          end
          outText+="<input type='hidden' name='productattribute'  value='"+productattributenames.to_s+"'>"
          outText+="</form></tbody></table></div></td></tr></table>"
        end
      end
    end
    render_text outText
  end
  def deleteItemReally
    textreturn="出现异常，请与系统管理员联系!@|"
    textreturnArray=textreturn.split("@|")
    configure_params=params[:configure_params]
    event_code=params[:event_code]
    outText=""
    if event_code!=nil then 
      if configure_params!=nil then
        configure_params=Iconv.iconv("GB2312","UTF-8",configure_params).to_s
        configureParamsArray=configure_params.split("@")
        if configureParamsArray[0]!=nil && configureParamsArray[1]!=nil then
          begin
          confChgReproductProducts=ConfChgReproductProducts.new
          confs=confChgReproductProducts.findAllCols(event_code,configureParamsArray[0],configureParamsArray[1])
          for conf in confs
            ConfChgReproductProducts.delete(conf.ID)
          end
          relaChgConfigure=RelaChgConfigure.new
          relas=relaChgConfigure.findAllCols(event_code,configureParamsArray[0],configureParamsArray[1])
          for rela in relas
            RelaChgConfigure.delete(rela.ID)
          end
          outText="ok"
          rescue Exception => e  
             outText=textreturnArray[0]
             render_text outText
             puts(e.to_s)
             print e.backtrace.join("[删除配置项异常--(/scm/event/note/need_changed_items_controller)]\n")
          end
        end
      end
    end
    render_text outText
  end
  def projectProductSubmit
    tempText="请与系统管理员联系！@提交成功！"
    tempTextArray=tempText.split("@")
    outText="";
    projectparams=params[:projectparams]
    productparams=params[:productparams]
    event_code=params[:event_code]
    begin
      if event_code!=nil then
        if projectparams!=nil then
          projectRowArray=projectparams.split("|@")
          for projectRow in projectRowArray
            projectOnerowArray=projectRow.split("@")
            confChgReprojectProjects=ConfChgReprojectProjects.find(:first,:conditions=>["ID =? ",projectOnerowArray[0]])
            confChgReprojectProjects.id=confChgReprojectProjects.ID
            confChgReprojectProjects.CAN_USE_FLAG=projectOnerowArray[1]
            confChgReprojectProjects.save
          end
        end
        if productparams!=nil then
          productRowArray=productparams.split("|@")
          for productRow in productRowArray
            productOnerowArray=productRow.split("@")
            confChgReproductProducts=ConfChgReproductProducts.find(:first,:conditions=>["ID =? ",productOnerowArray[0]])
            if confChgReproductProducts!=nil then
              confChgReproductProducts.id = confChgReproductProducts.ID
              confChgReproductProducts.CAN_USE_FLAG=productOnerowArray[1]
              confChgReproductProducts.save
            else
              puts("now data")
            end
          end
        end
        outText=tempTextArray[1]
      else
        outText=tempTextArray[0]
      end
    rescue Exception => e  
              outText=tempTextArray[0]
              render_text outText
             puts(e.to_s)
             print e.backtrace.join("[删除配置项异常--(/scm/event/note/need_changed_items_controller)]\n")
    end
    render_text outText
  end
end
