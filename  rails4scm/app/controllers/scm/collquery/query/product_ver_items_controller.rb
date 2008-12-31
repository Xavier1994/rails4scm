class Scm::Collquery::Query::ProductVerItemsController < ApplicationController
   before_filter :fileLoginSessionNil
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
    @productItems=nil
    if @product_code!=nil&&@product_vers!=nil then
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
    outText="<table>"
    @productItemsH=nil
    if product_code!=nil&&product_vers!=nil&&configure_code!=nil then
      @productItemsH=productItemsHistory(product_code,product_vers,configure_code)
      outText="<table>"
      if @productItemsH!=nil then
        for productItem in @productItemsH
             outText="<tr>"
             outText+="<td class='td6'>&nbsp;"+productItem.H_CONFIG_VERS+"</td>"
             outText+="</tr>"
        end
      else
             outText="<tr>"
             outText+="<td class='td6'>&nbsp;</td>"
             outText+="</tr>"
      end
      outText+="</table>"
    end
    render_text outText
  end
end
