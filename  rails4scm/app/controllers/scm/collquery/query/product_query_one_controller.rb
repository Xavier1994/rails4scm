class Scm::Collquery::Query::ProductQueryOneController < ApplicationController
 def index
    curPageSize = params[:page]
    pageSize = 22

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
    if(curPageSize != nil&&curPageSize!="")
      @whereProduct = session[:productQueryOneWhereProduct]
      @whereProductVer = session[:productQueryOneWhereProductVer]
      @product = session[:productQueryOneProduct]
      @productVer= session[:productQueryOneProductVer]
    else
      session[:productQueryOneWhereProduct] = @whereProduct
      session[:productQueryOneWhereProductVer] = @whereProductVer
      session[:productQueryOneProduct] = @product
      session[:productQueryOneProductVer] = @productVer
    end
    @items =nil
    if @product!=nil&&@product!="" then
       @items = list(pageSize,curPageSize,@product,@productVer)
       softwareProduct=SoftwareProduct.new
       softproducts=softwareProduct.getProductByCode(@product)
       for softproduct in softproducts
         @productName=softproduct.PRODUCT_NAME
       end
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
    
    if product_code!=nil&&product_code!="" then
      verHtml+="<select style=\"width:100px\" name=\"productVer\">"
      @productVers=productVerList(product_code)
                 if @productVers!=nil then 
                    for productVer in @productVers 
                    verHtml+="<option value=\""+productVer.PRODUCT_VERS+"\">"+productVer.PRODUCT_VERS+"</option>"
                    end 
                end
      verHtml+="</select>"
    else
      verHtml+="<select></select>"
    end
    
    render_text verHtml 
  end
  
private  
 def list(pageSize,curPageSize,product,productVer)
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
