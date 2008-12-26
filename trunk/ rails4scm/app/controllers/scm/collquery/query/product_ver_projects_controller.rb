class Scm::Collquery::Query::ProductVerProjectsController < ApplicationController

  def index
    product_code=params[:product_code]
    product_vers=params[:product_vers]
    @productProjects=nil
    if product_code!=nil&&product_vers!=nil then
    @productProjects=productVerProjects(product_code,product_vers)
    end
  end
  private 
  def productVerProjects(product_code,product_vers)
    productItem=PruductConfigueItem.new();
   return productItem.productVerProjects(product_code,product_vers)
  end
end
