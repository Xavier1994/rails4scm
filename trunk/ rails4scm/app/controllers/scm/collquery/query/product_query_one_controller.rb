class Scm::Collquery::Query::ProductQueryOneController < ApplicationController

 def index
    curPageSize = params[:page]
    pageSize = 18
    @whereProduct     = params[:whereProduct]
    @whereProductVer   = params[:whereProductVer]
    @product   = params[:product]
    @productVer  = params[:productVer]
    if(@whereProduct!=nil&&@whereProduct == "true"&&@product!=nil&&@product =="") then
      @product = nil
    elsif(@whereProduct==nil) then
      @product = nil
    end
    if(@whereProductVer !=nil&&@whereProductVer == "true"&&@productVer !=nil&&@productVer =="") then
        @productVer =nil
    elsif(@whereProductVer ==nil) then
      @productVer =nil
    end
    if @product!=nil&&@product!="" then
       @items = list(pageSize,curPageSize,@product,@productVer)
       @productVers=productVerList(@product)
       @verHtml="<select style=\"width:100px\" name=\"productVer\">"
       if @productVers!=nil then 
            for productVer in @productVers 
                if productVer.PRODUCT_VERS==@productVer then
                        @verHtml+="<option selected=\"true\"  value=\""+productVer.PRODUCT_VERS+"\">"+productVer.PRODUCT_VERS+"</option>"
                else
                        @verHtml+="<option  value=\""+productVer.PRODUCT_VERS+"\">"+productVer.PRODUCT_VERS+"</option>"
                end
            end 
       end
       @verHtml+="</select>"
    end
    @products=productList()
    
  end
  
  def getvers
    product_code=params[:product_code]
    verHtml=""
    verHtml+="<select style=\"width:100px\" name=\"productVer\">"
    if product_code!=nil&&product_code!="" then
      @productVers=productVerList(product_code)
                 if @productVers!=nil then 
                    for productVer in @productVers 
                    verHtml+="<option value=\""+productVer.PRODUCT_VERS+"\">"+productVer.PRODUCT_VERS+"</option>"
                    end 
                end
    end
    verHtml+="</select>"
    render_text verHtml 
  end
  
private  
 def list(pageSize,curPageSize,product,productVer)
   puts(product,productVer)
    productItems = PruductConfigueItem.new()
    return productItems.getProductConfigueItems(pageSize,curPageSize,product,productVer)
  end  
 
 def productList()
    productItems = PruductConfigueItem.new()
    return productItems.productList()
  end  
  
 def productVerList(product_code)
    productVers = SoftwareProductVer.new()
    return productVers.productVerList(product_code)
  end 
end
