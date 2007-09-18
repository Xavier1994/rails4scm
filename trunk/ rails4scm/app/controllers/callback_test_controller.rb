class CallbackTestController < ApplicationController
    def index
       @callback=String.new("")
       set_callback_object @callback  
       render_text "this is index"
    end
end
