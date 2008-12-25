class Scm::Collquery::Query::ProductBaseTreeController < ApplicationController
  before_filter :fileLoginSessionNil
  def index
    @productsTree =productTreeList()
  end
  
  private
  def  productTreeList()
    productItems=PruductConfigueItem.new()
    @products=productItems.productTreeList()
    topText="产品清单W@"
    topTextArray=topText.split("W@");
    begin
      url = "/scm/collquery/query/product_baseinfo"
      inst=FsTreeModel::Treeview.new(topTextArray[0],url,0,'mainvalue',"product_baseInfo_main")
      k = 1
      for product in @products
          product_code = product.PRODUCT_CODE
          url = "/scm/collquery/query/product_baseinfo?code="
          product_name = product.PRODUCT_NAME
          url = url.to_s + product_code.to_s
          sub1=FsTreeModel::Treeview.new(product_name,url,k,'value' +k.to_s,"product_baseInfo_main")
          inst<<sub1
          k = k + 1
      end
      rescue Exception => e  
          print e.backtrace.join("[构建产品树异常--(/scm/collquery/query/product_base_tree)]\n")
    end
    return inst
  end
  
  
end
