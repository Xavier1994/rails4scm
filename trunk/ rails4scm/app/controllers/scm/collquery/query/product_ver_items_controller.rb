class Scm::Collquery::Query::ProductVerItemsController < ApplicationController

  def index
    @product_code=params[:product_code]
    @product_vers=params[:product_vers]
    @productItems=nil
    if @product_code!=nil&&@product_vers!=nil then
    @productItems=productVerItems(@product_code,@product_vers)
    end
  end
  private 
  def productVerItems(product_code,product_vers)
    productItem=PruductConfigueItem.new();
   return productItem.productItems(product_code,product_vers)
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
    outText=""
    @productItemsH=nil
    if product_code!=nil&&product_vers!=nil&&configure_code!=nil then
      @productItemsH=productItemsHistory(product_code,product_vers,configure_code)
      if @productItemsH!=nil then
        for productItem in @productItemsH
             #outText="<tr>"
             outText+="<td class='td6'>&nbsp;"+productItem.H_CONFIG_VERS+"</td>"
             #outText+="</tr>"
        end
      end
    end
    puts(outText)
    render_text outText
  end
end
