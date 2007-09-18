# ��չ <tt>ActionController::Routing::RouteSet</tt> ���Ա�����/mytreeview/·����֧�֡�
class ActionController::Routing::RouteSet

  alias_method :__draw, :draw

  # ����ȱʡ��<tt>RouteSet#draw</tt> �������Ա㽫�µ�route����<tt>TreeController</tt>���·��

  def self.draw
    old_routes = @routes
    @routes = []
    
    begin 
      create_tree_routes()
      @routes+=old_routes   #fxq add �����ϵ�·��
      yield self                   #do map����˼�ɣ�
    rescue
      @routes = old_routes
      raise
    end
    write_generation()
    write_recognition()
  end

  # ����/mytreeview/·����ָ��<tt>TreeController</tt>
  def self.create_tree_routes()
     named_route "mytreeview_callback", "/mytreeview/callback/*old_url", :controller=>'fs_tree_callback', :action=>'callback'
     connect "/mytreeview/*whatever", :controller=>'fs_tree_callback', :action=>'error'
  end

end