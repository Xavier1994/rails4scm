class Scm::Collquery::Query::ProductQueryTwoController < ApplicationController

  def index
    text ="��Ʒ������ϢW@"
    blockTextArray = text.split("W@")
    @blockDefs = Array.new 
    @blockDefs[0] = blockTextArray[0]
    @blockDefs[1] = "PRODUCT_BASEINFO_DIV"
    @blockDefs[2] = true
  end
end
