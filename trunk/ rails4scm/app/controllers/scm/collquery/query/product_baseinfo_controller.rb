class Scm::Collquery::Query::ProductBaseinfoController < ApplicationController
   before_filter :fileLoginSessionNil
  def index
     product_code = params[:code]
    @product_code=product_code
    @products = nil
    @productVers = nil
    @productcodeArray=Array.new(1)
    @productcodeArray[0]=product_code
    if product_code != nil then
      productItems=PruductConfigueItem.new()
      @products=productItems.productBaseinfo(product_code)
      @productVers=productItems.productVersinfo(product_code)
    end
  end
  
  def goProductVerItems
    productCode=params[:productCode]
    productVer=params[:productVer]
    redirect_to(:controller =>"product_ver_items?product_code="+productCode+"&product_vers="+productVer,:action => :index) 
  end
end
