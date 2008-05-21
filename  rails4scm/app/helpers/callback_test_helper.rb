module CallbackTestHelper
   def render_link
      old_url=request.request_uri()
      return "<a href=\"/mytreeview/callback?event=test&old_url=#{old_url} \" > click here </a>"
   end
end
