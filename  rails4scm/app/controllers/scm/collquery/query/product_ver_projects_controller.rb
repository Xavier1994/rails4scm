class Scm::Collquery::Query::ProductVerProjectsController < ApplicationController
  def index
    curPageSize = params[:page]
    pageSize = 14
    product_code=params[:product_code]
    @product_vers=params[:product_vers]
    if(curPageSize != nil&&curPageSize!="")
      @product_code = session[:product_ver_projects_product_code]
      @product_vers = session[:product_ver_projects_product_vers]
    else
      session[:product_ver_projects_product_code] = @product_code
      session[:product_ver_projects_product_vers] = @product_vers
    end
    @product_name=nil
    @productProjects=nil
    if product_code!=nil&&@product_vers!=nil then
      pruductConfigueItem=PruductConfigueItem.new
      products=pruductConfigueItem.productBaseinfo(product_code)
      for product in products
        @product_name=product.PRODUCT_NAME
      end
      @productProjects=productVerProjects(pageSize,curPageSize,product_code,@product_vers)
    end
  end
  private 
  def productVerProjects(pageSize,curPageSize,product_code,product_vers)
    productItem=PruductConfigueItem.new();
   return productItem.productVerProjects(pageSize,curPageSize,product_code,product_vers)
  end
end
