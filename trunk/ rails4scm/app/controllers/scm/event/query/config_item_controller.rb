class Scm::Event::Query::ConfigItemController < ApplicationController

  def index
    event_code = params[:event_code]
    flag = params[:flag]
    if event_code != nil then
      session[:ConfigItem_event_code] = event_code
    end
    
    if event_code == nil then
      event_code = session[:ConfigItem_event_code]
    end
    curPageSize = params[:page]
    pageSize = 23
    
    config_code_hidden = params[:config_code_hidden]
    if(config_code_hidden != nil) then
      session[:config_code_hidden_session] = config_code_hidden
    end
    if(flag.to_s == "1") then
      session[:config_code_hidden_session] = nil
    end
    if(config_code_hidden == nil) then
      config_code_hidden = session[:config_code_hidden_session]
    end
    
    configureItem = ConfigureItem.new
    @ConfigureItem = configureItem.findConfig(pageSize, curPageSize, event_code)
    @config_code_hidden = config_code_hidden
    
    #开始查询未升级、已升级的产品和项目的列表
    if config_code_hidden != nil then
      @ConfigureItemOne = configureItem.findConfigOne(@config_code_hidden, event_code)
      conf = ConfChgReproductProducts.new
      @projectNon   = conf.findProjectNon(event_code,@ConfigureItemOne[0].CONFIGURE_CODE, @ConfigureItemOne[0].PRE_VERSION)
      @projectBlock = conf.findProjectBlock(event_code,@ConfigureItemOne[0].CONFIGURE_CODE, @ConfigureItemOne[0].PRE_VERSION)
      @itemNon   = conf.findItemNon(event_code,@ConfigureItemOne[0].CONFIGURE_CODE, @ConfigureItemOne[0].PRE_VERSION)
      @itemblock = conf.findItemBlock(event_code,@ConfigureItemOne[0].CONFIGURE_CODE, @ConfigureItemOne[0].PRE_VERSION)
    end
  end
end
