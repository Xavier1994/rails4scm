class Scm::Collquery::Query::ConfigProjectController < ApplicationController
  before_filter :fileLoginSessionNil
  
  #��ѯ�����Ŀ
  def index
      configure_code = params[:code]
      configure_vers =  params[:configure_vers]
      
      project = PrjConRela.new()
      @project = project.findPrjConRela(configure_code, configure_vers)
  end
end
