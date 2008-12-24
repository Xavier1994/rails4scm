class Scm::Collquery::Query::ProductVerItemsController < ApplicationController

  def index
    product_code=params[:product_code]
    product_vers=params[:product_vers]
    @productItems=nil
    if product_code!=nil&&product_vers!=nil then
    @productItems=productVersinfo(product_code,product_vers)
    end
  end
  private 
  def productVersinfo(product_code,product_vers)
    productItem=PruductConfigueItem.new();
   return productItem.productItems(product_code,product_vers)
  end
end
