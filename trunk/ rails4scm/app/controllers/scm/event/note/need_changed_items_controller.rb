class Scm::Event::Note::NeedChangedItemsController < ApplicationController

  def index
    @event_code=params[:event_code]
  end

  def changeItem
    configure_params=params[:configure_params]
    event_code=params[:event_code]

    outText="<table cellpadding=0 cellspacing=0 border=0 style=\"width:100%;bordercolo:#878787 ;border-left-style: solid; border-left-width: 1px; border-right-style: solid; border-right-width: 1px\"><thead class=\"td_header_bak2\"><tr><td class=\"td_header_bak2\" width=\"160px\">配置项名称</td><td class=\"td_header_bak3\" width=\"70px\">配置项版本</td><td class=\"td_header_bak3\" width=\"80px\">配置项编号</td><td class=\"td_header_bak3\" width=\"80px\">事件编号</td></tr></thead><tbody>"
    @selectedItems=nil
    b=true
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
              k+=1
            end
          else
            outText="@@@@@@已存在变更申请,配置项:"+configureParamsArray[1].to_s+"  版本为:"+configureParamsArray[2].to_s+"!"
            b=false
          end
        end
      end
        if b==false then
        else
          configureItem=ConfigureItem.new
          configureItems=configureItem.findEventConfigureItemSelected(event_code)
          if configureItems!=nil && configureItems.size>0 then
            for configureitem in configureItems
              outText+="<tr>"
              outText+="<td class='td6' width='160px'>&nbsp;"+configureitem.CONFIGURE_NAME+"</td>"
              outText+="<td class='td7' width='70px'>&nbsp;"+configureitem.CONFIGURE_VERS+"</td>"
              outText+="<td class='td7' width='80px'>&nbsp;"+configureitem.CONFIGURE_CODE+"</td>"
              outText+="<td class='td7' width='80px'>&nbsp;"+configureitem.EVENT_CODE+"</td>"
              outText+="</tr>"
            end
          end
          outText+="</tbody></table>"
        end
    end
    render_text outText
  end
end
