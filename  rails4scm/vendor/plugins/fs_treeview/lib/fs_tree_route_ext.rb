# 扩展 <tt>ActionController::Routing::RouteSet</tt> 类以便增加/mytreeview/路径的支持。
class ActionController::Routing::RouteSet

  alias_method :__draw, :draw

  # 重载缺省的<tt>RouteSet#draw</tt> 方法，以便将新的route加入<tt>TreeController</tt>类的路径

  def self.draw
    old_routes = @routes
    @routes = []
    
    begin 
      create_tree_routes()
      @routes+=old_routes   #fxq add 保持老的路径
      yield self                   #do map的意思吧？
    rescue
      @routes = old_routes
      raise
    end
    write_generation()
    write_recognition()
  end

  # 增加/mytreeview/路径，指向<tt>TreeController</tt>
  def self.create_tree_routes()
     named_route "mytreeview_callback", "/mytreeview/callback/*old_url", :controller=>'fs_tree_callback', :action=>'callback'
     connect "/mytreeview/*whatever", :controller=>'fs_tree_callback', :action=>'error'
  end

end