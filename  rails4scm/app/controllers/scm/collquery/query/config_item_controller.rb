class Scm::Collquery::Query::ConfigItemController < ApplicationController
  before_filter :fileLoginSessionNil
  
  def index
    curPageSize = params[:page]
    checkflagurl = params[:checkflag_url]
    pageSize = 18
    @configure_name = params[:configure_name]
    @configure_type = params[:configure_type]
    @configure_code = params[:configure_code]
    if(@configure_name == "") then
      @configure_name = nil
    end
    if(@configure_type == "") then
      @configure_type = nil
    end
    if(@configure_code == "") then
      @configure_code = nil
    end
    if(curPageSize != nil)
      @configure_name = session[:configure_name_session]
      @configure_type = session[:configure_type_session]
      @configure_code = session[:configure_code_session]
    else
      session[:configure_name_session] = @configure_name
      session[:configure_type_session] = @configure_type
      session[:configure_code_session] = @configure_code
    end
    
    #²éÑ¯
    if(checkflagurl == nil || checkflagurl == "")
      @configureItem = getData(pageSize,curPageSize,@configure_name,@configure_type,@configure_code)
    end
  end
  
  private
     #²éÑ¯
     def getData(pageSize,curPageSize,configure_name,configure_type,configure_code)
       configureItem = ConfigureItem.new
       item = configureItem.findItemAll(pageSize,curPageSize,configure_name,configure_type,configure_code) 
       return item
     end
end
