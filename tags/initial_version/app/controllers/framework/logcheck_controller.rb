require 'kernel/operator'

class Framework::LogcheckController < ApplicationController
      def index()
          @operator=session[:operator]
          if @operator==nil then
              @operator=Operator.new()
              session[:operator]=@operator
          end
          @operator.userName='super';
          @operator.passWord='none'
       end

       def login()
          opr=params[:operator]
          p  opr
          if opr[:passWord].empty?() then
             redirect_to :action => 'index'
          else
             session[:operator].passWord=opr[:passWord]
             redirect_to :action => 'open_home'
          end
       end
  
       def open_home()
          # do loging ?
       end
end
