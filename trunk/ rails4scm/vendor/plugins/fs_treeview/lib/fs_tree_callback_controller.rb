  
# ��չaction controller �Ա�֧������Ļص�
class FsTreeController < ActionController::Base

#  after_filter :cache_fatched_files
  
  def callback(*old_url)
     p "---the param and old_url ="    
       p params
       p old_url
     p "---the callback object is��in callback func��:"
       p callback_object    #     ActionController ���Ѿ���չ
       redirect_to(old_url.to_s)
  end

  def error
    render :nothing => true, :status => 404
  end
  
 private
  
  def cache_fatched_files
    path = request.request_uri
    begin
      FsTreeController.cache_page(response.body, path )
    rescue
      STERR.puts "Cache Exception: #{$!}"
    end
  end

end


    