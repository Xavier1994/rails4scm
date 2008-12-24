class Scm::Collquery::Query::ProductBaseinfoController < ApplicationController

  def index
     product_code = params[:code]
    @products = nil
    @productVers = nil
    if product_code != nil then
      productItems=PruductConfigueItem.new()
      @products=productItems.productBaseinfo(product_code)
      @productVers=productItems.productVersinfo(product_code)
    end
  end
end
