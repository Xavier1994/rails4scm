class Scm::Collquery::Query::ProductQueryTwoController < ApplicationController

  def index
    text ="��Ʒ������ϢW@��Ӧ������W@������Ŀ¼ά��W@�����ĿW@����²�ƷW@"
    blockTextArray = text.split("W@")
    @blockDefs = Array.new 
    @blockDefs[0] = blockTextArray[0]
    @blockDefs[1] = "PRODUCT_BASEINFO_DIV"
    @blockDefs[2] = true
    @blockDefs[3] = blockTextArray[1]
    @blockDefs[4] = "ITEM_DIV"
    @blockDefs[5] = false
    @blockDefs[6] = blockTextArray[2]
    @blockDefs[7] = "DEVELOP_LIB_CATELOG_M_DIV"
    @blockDefs[8] = false
    @blockDefs[9] = blockTextArray[3]
    @blockDefs[10] = "PROJECT_DIV"
    @blockDefs[11] = false
    @blockDefs[12] = blockTextArray[4]
    @blockDefs[13] = "ADD_NEW_PRODUCT_DIV"
    @blockDefs[14] = false
  end
end
