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
    if @product!=nil then
    @items = list(pageSize,curPageSize,@product,@productVer)
    end
    @products=productList()
    @productVers=productVerList()
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
  
 def productVerList()
    productVers = SoftwareProductVer.new()
    return productVers.productVerList()
  end 
end
