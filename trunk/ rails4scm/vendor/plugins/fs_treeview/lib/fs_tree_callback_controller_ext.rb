require 'fs_tree_model'

# 扩展 ActionController::Base类，以便支持组件的回调
ActionController::Base.class_eval do 

   class << self  
      alias_method :__hidden_actions, :hidden_actions

# 重载父类标准的hidden_actions方法，以便使得callback加入到映射之中
      def hidden_actions()
         __hidden_actions() 
         hidden=read_inheritable_attribute(:hidden_actions)
         hidden.delete('fs_tree_callback') 
         write_inheritable_attribute(:hidden_actions, hidden)
      end 
  end
  
  def fs_tree_callback()
     helper=session[:fs_treeview_helper]
     if helper==nil then return end
       
     whereClick=params[:item]
     itemId=params[:id]
     old_url=params[:old_url]
     case whereClick
          when 'leadingImg'
              helper.onLeadingImageClick(itemId)
          when 'checkImg'
              helper.onCheckImageClick(itemId)
          when 'nodeImg'
              helper.onNodeImageClick(itemId)
          when 'label'
              helper.onNodeLableClick(itemId)
     end
     redirect_to(old_url.to_s)
  end

  def error()
     render :nothing => true, :status => 404
  end
  
end
