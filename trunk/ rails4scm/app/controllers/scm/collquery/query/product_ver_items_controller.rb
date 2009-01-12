class Scm::Collquery::Query::ProductVerItemsController < ApplicationController
  def index
    curPageSize = params[:page]
    pageSize = 10
    @product_code=params[:product_code]
    @product_vers=params[:product_vers]
    if(curPageSize != nil&&curPageSize!="")
      @product_code = session[:product_ver_tems_product_code]
      @product_vers = session[:product_ver_tems_product_vers]
    else
      session[:product_ver_tems_product_code] = @product_code
      session[:product_ver_tems_product_vers] = @product_vers
    end
    
    @product_name=nil
    @productItems=nil
    if @product_code!=nil&&@product_vers!=nil then
      pruductConfigueItem=PruductConfigueItem.new
      products=pruductConfigueItem.productBaseinfo(@product_code)
      for product in products
        @product_name=product.PRODUCT_NAME
      end
      @productItems=productVerItems(pageSize,curPageSize,@product_code,@product_vers)
    end
  end
  private 
  def productVerItems(pageSize,curPageSize,product_code,product_vers)
    productItem=PruductConfigueItem.new();
   return productItem.productItems(pageSize,curPageSize,product_code,product_vers)
  end
  
  def productItemsHistory(product_code,product_vers,configure_code)
    productItem=PruductConfigueItem.new();
   return productItem.productItemsHistory(product_code,product_vers,configure_code)
  end
  public
  def history
    product_code=params[:product_code]
    product_vers=params[:product_vers]
    configure_code=params[:configure_code]
    configue_Name=params[:configueName]
    if configue_Name==nil then
      configue_Name=""
    end
    configue_Name=Iconv.iconv("GB2312","UTF-8",configue_Name)
    outText=""
    @productItemsH=nil
    if product_code!=nil&&product_vers!=nil&&configure_code!=nil then
      @productItemsH=productItemsHistory(product_code,product_vers,configure_code)
      outText="<table cellpadding=0 cellspacing=0 border=0 style=\"width:100%;bordercolo:#878787 ;border-left-style: solid; border-left-width: 1px; border-right-style: solid; border-right-width: 1px\"><hr/><thead class=\"td_header_bak2\"><tr><td  class=\"td_header_bak2\" width=\"240px\"><div align=\"center\">配置项名称</div></td><td  class=\"td_header_bak3\" width=\"80px\"><div align=\"center\">历史版本</div></td></tr></thead>"
      if @productItemsH!=nil then
        for productItem in @productItemsH
             outText+="<tbody><tr>"
             outText+="<td class='td6'>&nbsp;"+configue_Name.to_s+"</td><td class='td7'>&nbsp;"+productItem.H_CONFIG_VERS+"</td>"
             outText+="</tr></tbody>"
        end
      else
             outText="<tbody><tr>"
             outText+="<td class='td6'>&nbsp;</td><td class='td7'>&nbsp;</td>"
             outText+="</tr></tbody>"
      end
      outText+="</table>"
    end
    render_text outText
  end
end
