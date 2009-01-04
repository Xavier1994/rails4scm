class Scm::Event::Note::NeedSourceItemsController < ApplicationController
  def index
    @event_code=params[:event_code]
    @eventItemsSource=session[:eventItemsSource]
    session[:eventItemsSource]=nil
  end
  
  def query
    configure_name=params[:configure_name]
    configure_type=params[:configure_type]
    if configure_name==nil then
      configure_name=""
    end
    if configure_type==nil then
      configure_type=""
    end
    @eventItemsSource=findEventConfigureItem(configure_name,configure_type)
    session[:eventItemsSource]= @eventItemsSource
    redirect_to :action => 'index'
  end

  def findEventConfigureItem(configure_name,configure_type)
    configurItem=ConfigureItem.new
    return configurItem.findEventConfigureItem(configure_name, configure_type)
  end
end
