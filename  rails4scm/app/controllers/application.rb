# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_rails4scm_session_id'

  before_filter :configure_charsets
  before_filter :fileLoginSessionNil
 
  def configure_charsets
		  @response.headers["Content-Type"] = "text/html; charset=GB2312"
#		  suppress(ActiveRecord::StatementInvalid) do
#		     	ActiveRecord::Base.connection.execute 'SET NAMES UTF8'
#		  end
 	  end
  #过滤器功能来阻止不经过登录页面进入系统或者session失效
  def fileLoginSessionNil()
    name = self.class.to_s
    if session[:operator] == nil and name != "Framework::LogcheckController" then
      redirect_to(:controller =>"/framework/logcheck", :action =>"index",:loginflag=>"1")
    end
  end
end
