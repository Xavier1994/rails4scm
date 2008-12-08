require 'kernel/operator'

class Framework::LogcheckController < ApplicationController
      def index()
          @userName="llr"; 
          @passWord="111111";
       end
       
       def login()
         begin 
           operid = params[:userName]
           pswd  = params[:passWord]
           @userName=operid
           @passWord=pswd
           
           if operid == "" or operid == nil then
             @login_flag="1"
           else
             if pswd == "" or pswd == nil then
               @login_flag="2"
             else
               op=UserInfo.new()
                @operuser = op.findOne(operid,pswd);

                if @operuser == nil then 
                  @login_flag="3"
                  reset_session
                else
                  session[:operator]=@operuser
                  redirect_to :action => 'open_home'
                end
             end 
           end
         rescue 
           redirect_to(:action => :index)
         end
       end
  
       def open_home()
          if session[:operator] == nil then
            redirect_to(:action => :index) 
          end
       end
       
       def loginout()
         reset_session
         session[:operator]=nil
         redirect_to(:action => :index) 
       end
end
