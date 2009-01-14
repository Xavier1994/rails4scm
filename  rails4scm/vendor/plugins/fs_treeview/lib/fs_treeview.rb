require 'fs_tree_model'
require 'log4r'

module FsTreeview

public

     def js_treeview_tag(treeview)
        if not treeview.is_a?(FsTreeModel::Treeview)
            return "tree generation not support for type #{treeview.class}"
        end
        return TreeViewJsHelper.gen_tree(treeview)
      end
      
# 输出HTML树。 约定callBackObj 可以是任何类型的对象，但必须接受回调方法: onTreeViewEvent(TreeviewEvent) 否则不产生回调动作

     def treeview_tag(treeview, treeviewState, callBackObj=nil)
#        p '---debug: now in tag routine'
#        p treeview
#        p treeviewState
        
        if not treeview.is_a?(FsTreeModel::Treeview)
            return "tree generation not support for type #{treeview.class}"
        end
          
        if not treeviewState.is_a?(FsTreeModel::TreeviewState)
            return "tree generation parameter state expects type FsTreeModel::TreeviewState, but got type #{treeviewState.class}"
        end 

        helper=session[:fs_treeview_helper]
        if helper==nil 
            helper=TreeViewHelper.new(treeview, treeviewState, callBackObj)
            session[:fs_treeview_helper]=helper
        end
        return helper.renderComponent(self)
    end

protected

   include Log4r 
   
   class Log4r::Logger   # 不知为什么不支持[]了，只好根据源码再重新定义一遍
     def self.[](_fullname)
        return RootLogger.instance if _fullname=='root' or _fullname=='global'
        Repository[_fullname]
    end
  end
  
# 辅助JS方式的treeview输出
  class TreeViewJsHelper
    def self.gen_item(subtree,parentName,count)
       tree_html = "var #{parentName}_#{count} = new WebFXTreeItem(\'#{subtree.label}\',\'#{subtree.url}\'," \
          +"\'#{subtree.target}\', \'#{subtree.icon}\', \'#{subtree.openIcon}\' );\r\n"
       tree_html += "#{parentName}.add(#{parentName}_#{count});\r\n"
       if not subtree.leaf? 
           subcount=1
           subtree.each do |subsub|
              tree_html+=gen_item(subsub,"#{parentName}_#{count}",subcount)
              subcount +=1
           end
       end
       return tree_html
    end
    
    def self.gen_tree(tree)
      tree_html = "<LINK href='/stylesheets/xtree20.css' rel='stylesheet' type='text/css'>"    
      tree_html += "<script type='text/javascript' src='/javascripts/xtree20.js'> </script> "
      
      tree_html += "<script type='text/javascript'>\r\n"
      tree_html += "var root = new WebFXTree('#{tree.label}','#{tree.url}',"\
                       +"'_self', \'#{tree.icon}\',  \'#{tree.openIcon}\' );\r\n"
      tree.each do |subtree|
        tree_html += gen_item(subtree,'root',1)
      end
      tree_html +="root.setBehavior('classic');\r\n"
      tree_html +="document.write(root);\r\n"
      tree_html +="</script>\r\n"
    end
  end
  
 # 辅助单个treeviewItem的输出（表格方式） 实际上没必要分成两个类，但为了清晰，写成模块形式
  module  TreeViewItemHelper
     attr_reader :treeViewModel,:treeviewState,:listenerObj #这些对象恐怕要存session中
     attr_accessor :closeRootImage,:openRootImage,:closeFolderImage,:openFolderImage,:fileImage,:selectedImage
     attr_accessor :checkedImage,:uncheckedImage   #选中与否的img
     attr_writer :selectable,:showFocus
     
     def selectable?() return @selectable  end
     def showFocus?() return @showFocus  end

     def initialize_item()
         @closeRootImage='/images/xtreeview/x20-organicon.gif'
         @openRootImage='/images/xtreeview/x20-openorganicon.gif'
         @closeFolderImage='/images/xtreeview/x20-foldericon.gif'
         @openFolderImage='/images/xtreeview/x20-openfoldericon.gif'
         @fileImage='/images/xtreeview/x20-file.gif'
         @selectedImage='/images/xtreeview/x20-selected.gif'
         @checkedImage='/images/xtreeview/x20-checked.bmp'
         @uncheckedImage='/images/xtreeview/x20-unchecked.bmp'
         @iImage='/images/xtreeview/x20-I.gif'
         @lImage='/images/xtreeview/x20-L.gif'
         @lMinusImage='/images/xtreeview/x20-Lminus.gif'
         @lPlusImage='/images/xtreeview/x20-Lplus.gif'
         @tImage='/images/xtreeview/x20-T.gif'
         @tMinusImage='/images/xtreeview/x20-Tminus.gif'
         @tPlusImage='/images/xtreeview/x20-Tplus.gif'
         @blankImage='/images/xtreeview/x20-blank.gif'
      end
  private
  #得到指定TreeViewItem 的图标
      def getNodeImage(treeviewItem, isNodeOpened, isFolder,isCurrent)
        if not treeviewItem.is_a?(FsTreeModel::Treeview)
            Log4r::Logger['treelog'].fatal("ERROR: treeviewItem type should be Treeview, but got #{treeview.class}")
            return "#"
        end
        icon=treeviewItem.icon();       
        openIcon=treeviewItem.openIcon(); 
# 由于树的所有节点可以都是“分组”类似MS的explorer，因此不论是否叶节点都显示当指针
        if isCurrent and showFocus?() then
           if isFolder then
             if not isNodeOpened then
                 if icon!=nil and not icon=="" then 
                   return icon 
                else  
                    return @closeFolderImage
                end #icon
            else  # if open
                 if openIcon!=nil and not openIcon=="" then 
                    return openIcon 
                 else
                    return @openFolderImage
                end #openIcon                   
            end
           else
             return @selectedImage
           end
        else if isFolder then
            if not isNodeOpened then
                 if icon!=nil and not icon=="" then 
                   return icon 
                else  
                    return @closeFolderImage
                end #icon
            else  # if open
                 if openIcon!=nil and not openIcon=="" then 
                    return openIcon 
                 else
                    return @openFolderImage
                end #openIcon                   
            end    
        else # if not folder
            if openIcon!=nil and not openIcon=="" then 
                return openIcon
            else 
                return @fileImage
            end 
        end # if  isFolder
        end # if  isCurrent and showFocus?() 
      end # of  getNodeImage
      
      def getIndentImage(isLast)
         if  isLast then
            return @blankImage
         else
            return @iImage
         end   
      end
  
      def getCheckImage(isChecked)
         if  isChecked then
            return @checkedImage
         else
            return @uncheckedImage
         end
      end
      
      def nodeOpened?(nodeId)
         if @treeviewState==nil then
            return false;
        else
            return @treeviewState.nodeExpanded?(nodeId);
        end
      end
      
      def nodeChecked?(nodeId)
         if @treeviewState==nil then
            return false;
        else
            return @treeviewState.nodeChecked?(nodeId);
        end
      end
      
      def currentNode?(nodeId)
         if @treeviewState==nil or nodeId==nil then return false end
         return nodeId.to_s==@treeviewState.currentNodeId() 
      end
      
      def renderNode(theNode,parent,depth,view)
        treeLogger=Log4r::Logger['treelog']
        if not theNode.is_a?(FsTreeModel::Treeview)
            treeLogger.fatal("ERROR: renderNode parameter 'theNode' type should be Treeview, but got #{treeview.class}")
            return "#"
        end        

        t=parent;     #临时变量
        iLevel=0;      #循环层次
        indent="";    #对位空白
        isLast=false; #叶子节点
        
        while t.parent()!=nil and iLevel<100 do
            isLast=t.lastNodeThisLevel?();
            #如果是根节点也不能作为最后节点处理            
            indent="<td> <a class='webfx-tree-icon' href='#'>"  
            indent+=" <img class='webfx-tree-icon' id='#{theNode.id}-indent-#{iLevel}' src='#{getIndentImage(isLast)}' border='0'>"   
            indent+=" </a> </td>" 
            t=t.parent() 
            iLevel +=1  
        end # of whild
          
        if iLevel>=100 then
            treeLogger.fatal( "ERROR:生成TreeViewItem组件的树型视图时,检测到树深度达到100？请检查树模型数据是否存在循环！")
            return "#"
        end
          
        isLast=theNode.lastNodeThisLevel?();
        isFolder=! theNode.leaf?();
        isOpen=nodeOpened?(theNode.id);  
        if !isFolder then  isOpen=true;  end     #固定使用OPENicon  // 由于STATE对象不包含该节点？？
        
        html  ="<table border=0 cellspacing=0 cellpadding=0> <tr><td> \r\n"   # table1
        html+="<table border=0 cellspacing=0 cellpadding=0> \r\n"   # table2
        html+="<tr id=\'#{theNode.id}\' class='webfx-tree-icon'> \r\n #{indent} \r\n"  # tr1
#            这里综合判断  生成 signIcon           
        if isFolder then
           if isOpen then 
              if isLast then signIcon=@lMinusImage else signIcon=@tMinusImage end
           else
              if isLast then signIcon=@lPlusImage else signIcon=@tPlusImage end
           end  #open
        else #folder
            if isLast then signIcon=@lImage else signIcon=@tImage end
        end #folder
        
        callback_url="/#{view.controller.controller_path()}/fs_tree_callback?old_url=#{view.request.path()}"
#        p '-----debug--- redirect old url='
#        p view.request.path()
#处理前导位图              
        if isFolder then
           url="#{callback_url}&item=leadingImg&id=#{theNode.id}"
        else
           url="#"   # 页节点不产生展开节点的连接! 只有folder才有连接
        end
        html+="<td width=18> <a href=\'#{url}\' class=\"webfx-tree-icon\"> \r\n"  #td1
        html+="<img src=\'#{signIcon}\' border=0 class=\"webfx-tree-icon\" > </a> </td>\r\n"  #td1
#处理check框        
        if self.selectable?() then
            html+="<td width=18> <a href=\'#{callback_url}&item=checkImg&id=#{theNode.id}\' class=\"webfx-tree-icon\"> \r\n"  #td1.5
            html+="<img src=\'#{getCheckImage(nodeChecked?(theNode.id))}\' border=0 > </a> </td> \r\n"  #td1.5
        end    
#处理节点位图           
        html+="<td width=18>  <a href=\'#{callback_url}&item=nodeImg&id=#{theNode.id}\' class=\"webfx-tree-icon\"> \r\n"  #td2
        html+="<img src=\'#{getNodeImage(theNode,isOpen,isFolder,currentNode?(theNode.id))}\' border=0 > </a></td>\r\n"  #td2
#处理节点标签
        html+="<td nowrap> <div class=\"webfx-tree-icon\">";
        html+="<a href=\'#{callback_url}&item=label&id=#{theNode.id}\' class=\"webfx-tree-icon\"> #{theNode.label.empty?() ? '&nbsp' : theNode.label} </a>"
        html+="</div></td>\r\n"

        html+="</tr> </table>\r\n"  # tr1  and table2
        html+="</td></tr>\r\n"   
#处理下级节点
        if isOpen then   # /*!kids.isEmpty()*/) //kids 肯定不为空！ 否则是util.tree类库错了
            html+="<tr id=\'#{theNode.id}-cont\' class='webfx-tree-container' style=\'display:#{isOpen ? 'block':'none'}\'>"  #tr2
            html+="<td> <table border=0 cellspacing=0 cellpadding=0 >"    #td3 and table3
            theNode.each do |childNode|
                html+="<tr><td> \r\n"
                html+=renderNode(childNode,theNode,depth+1,view);   #输出子树
                html+="</td></tr>\r\n"
            end  
        end # of if  如果没有打开，就不必输出子树
        html+="</table>"   # table 1        
        return html
        
     end # of renderNode
# 私有内部类，封装连接相关的信息，如ID，value等

      class LinkRelatedInfo
         attr_accessor :state, :nodeId, :value
         def initialize(_state, _nodeId,  _value)
            @state=_state; @nodeId=_nodeId; @value=_value;
         end
      end
       
      def getLinkRelatedInfo(nodeId)
         state=@treeviewState
         tag = @treeViewModel[nodeId]==nil ? '' : @treeViewModel[nodeId].value;
         return LinkRelatedInfo.new(state,nodeId,tag);
       end
       
#回调方法，调用注册的事件监听器     
     def onTreeStateChanged(objEvent)
        if @treeViewModel==nil or @listenerObj==nil  then return end  #回调对象为空，不回调
        
        if @listenerObj.respond_to?("onTreeViewEvent") then #如果回调对象不支持 onTreeViewEvent方法，不回调
           @listenerObj.onTreeViewEvent(objEvent)
           Log4r::Logger['treelog'].info 'event triggered: event='+objEvent.to_s
        end
      end
# 变换类名，防止书写罗唆      
      class TreeviewEvent <FsTreeModel::TreeviewEvent
      end
  public  
      def renderTreeviewItem(treeviewItem,view)
        treeLogger=Log4r::Logger['treelog']
        if not treeviewItem.is_a?(FsTreeModel::Treeview)
            treeLogger.fatal("ERROR: treeviewItem type should be Treeview, but got #{treeview.class}")
            return "#"
        end
        parent=treeviewItem.parent();
        if parent==nil then
            treeLogger.fatal("ERROR:无法获得TreeViewItem组件的父节点(parent),类库已被错误修改?");
            return "#"
        else
          renderNode(treeviewItem,parent,1,view);        
        end #if          
      end #of renderTreeviewItem
      
#前导位图被点击的事件  （导致张开等操作）
     def onLeadingImageClick(nodeId)
        info=getLinkRelatedInfo(nodeId);
        if info==nil then return; end
        
        if info.state.nodeExpanded?(nodeId) then # 展开、合拢操作不认为是选中
           info.state.collapse(nodeId);
           onTreeStateChanged(TreeviewEvent.new(TreeviewEvent::NODE_COLLAPSED,nodeId,info.value,@treeViewModel));
        else 
           info.state.expand(nodeId);
           onTreeStateChanged(TreeviewEvent.new(TreeviewEvent::NODE_EXPANDED,nodeId,info.value,@treeViewModel));
        end 
      end # onLeadingImageClick
      
#节点标签被点击的事件      
      def onNodeLableClick(nodeId)
        info=getLinkRelatedInfo(nodeId);
        if info==nil then return; end
           
        if nodeId==info.state.currentNodeId()  then
            onTreeStateChanged(TreeviewEvent.new(TreeviewEvent::SELECT_AGAIN,nodeId,info.value,@treeViewModel));
        else
            info.state.currentNodeId= nodeId
            onTreeStateChanged(TreeviewEvent.new(TreeviewEvent::SELECTION_CHANGED,nodeId,info.value,@treeViewModel));
        end           
      end     # of  onNodeLableClick
 
 #代表选中节点的位图，被点击的事件 
      def onCheckImageClick(nodeId)
        info=getLinkRelatedInfo(nodeId);
        if info==nil then return; end
        onNodeLableClick(nodeId) #首先触发选中事件
        
        if info.state.nodeChecked?(nodeId) then 
            info.state.uncheck(nodeId);
            onTreeStateChanged(TreeviewEvent.new(TreeviewEvent::NODE_UNCHECKED,nodeId,info.value,@treeViewModel));
        else
            info.state.check(nodeId);
            onTreeStateChanged(TreeviewEvent.new(TreeviewEvent::NODE_CHECKED,nodeId,info.value,@treeViewModel));
         end
       end  # of onCheckImageClick
       
 # 节点位图被点击   
      def onNodeImageClick(nodeId)
         return onNodeLableClick(nodeId);    #点击图标视同通过标签选择该节点
      end
      
  end  # of moduel  TreeViewItemHelper
  
  # 辅助整个treeview的输出，总控（表格方式） 
  class  TreeViewHelper
      include TreeViewItemHelper
      attr_writer :showRoot, :rootOpened
#避免重复      attr_accessor :closeRootImage,:openRootImage,:closeFolderImage,:openFolderImage,:fileImage,:selectedImage
     
      def showRoot?()  return @showRoot  end
      def  rootOpened?() return @rootOpened end   #根节点是否展开了
        
      def initialize(model,treeviewState,listenerObj,selectable=true,showFocus=true,showRoot=true)  
           @treeViewModel=model
           @treeviewState=treeviewState
           @listenerObj=listenerObj
           @showRoot=showRoot
           @selectable=selectable
           @showFocus=showFocus
           initialize_item()
           Logger.new('treelog')
      end
         
  private
#自用方法，得到根节点     
      def getRootNodeImage()
         if not rootOpened?() then
            imag=@treeViewModel.icon();
            if imag!=nil&&!(imag=="")  then 
               return imag
            else  
                return @closeRootImage;
            end
        else
           imag=@treeViewModel.openIcon();
           if imag!=nil&& !(imag.=="")  then 
               return imag
            else  
                return @openRootImage;
            end
         end
       end        
 
  public  
     def renderComponent(view)
        if @treeViewModel==nil  then return "empty treeview model!" end
        html="<div valign='top' align='left'>\r\n"; 
        html+="<LINK href='/stylesheets/xtree20.css' rel='stylesheet' type='text/css' >\r\n"
        html+= "<table border=\"0\" cellspacing=\"0\" cellpadding=\"0\" > \r\n"   #table1
        if showRoot? then
            html+="<tr><td> \r\n <table border=\"0\" cellspacing=\"0\" cellpadding=\"0\" >"   #table2
            html+="<tr id= \'#{@treeViewModel.id()}\' class='webfx-tree-icon' height=20>";
            html+="<td width=18>"
            html+="<a href='#' class='webfx-tree-icon'> <img src=\'#{getRootNodeImage()}\' border=0 class='webfx-tree-icon'> </a>"
            html+="</td>"   # /td witdh=18
            html+="<td nowrap> <div class='webfx-tree-icon'> "
            html+="<a href='#' class='webfx-tree-item'>#{@treeViewModel.label}</a> " 
            html+="</div> </td>"  # /td nowrap
            html+="</tr> </table> "  #table2 
            html+="</td></tr> \r\n"  #table2
        end   # if showRoot?()

        if not @treeViewModel.leaf?() then   #有子节点
            html+="<tr id=\'#{@treeViewModel.id()}-cont\' class='webfx-tree-container' style=\'#{rootOpened?() ? 'block':'none'}\'> \r\n" 
            html+="<td> <table border=\"0\" cellspacing=\"0\" cellpadding=\"0\"> \r\n"  #table3
            @treeViewModel.each do |node|
                 html+="<tr><td>\r\n"
                 html+=renderTreeviewItem(node,view)   #输出子树
                 html+="</td></tr>\r\n"
            end  #end each    
            html+="</table> </td></tr> \r\n"  #table3
        end  #havechild
        html+="</table> </div>\r\n"    #table1
        return html
      end #of renderComponent
       
      def onRootImageClick()
        logger=Log4r::Logger['treelog']
        if @treeviewState==nill then
            logger.fatal("发现程序错误:在处理TreeView组件的事件时,无法取得数据模型数据！类库已被错误修改?");
            return ;
        end
        
        if(irootOpened?()) then
            @treeviewState.collapse(@treeViewModel.id());
            onTreeStateChanged(TreeviewEvent.new(TreeviewEvent.NODE_COLLAPSED,@treeViewModel.id(),@treeViewModel.value,@treeViewModel));
        else
            @treeviewState.expand(@treeViewModel.id());
            onTreeStateChanged(TreeviewEvent.new(TreeviewEvent.NODE_EXPANDED,@treeViewModel.id(),@treeViewModel.value,@treeViewModel));
        end
     end

     def onRootLableClick 
        logger=Log4r::Logger['treelog']
        if @treeviewState==nill then
            logger.fatal("发现程序错误:在处理TreeView组件的事件时,无法取得数据模型数据！类库已被错误修改?");
            return ;
        end
        
        if  @rootId==@treeviewState.currentNode() then
            onTreeStateChanged(TreeviewEvent.new(TreeviewEvent.SELECT_AGAIN,@treeViewModel.id(),@treeViewModel.value,@treeViewModel));
        else
            @treeviewState.currentNode=@treeViewModel.id();
            onTreeStateChanged(TreeviewEvent.new(TreeviewEvent.SELECTION_CHANGED,@treeViewModel.id(),@treeViewModel.value,@treeViewModel));
        end
      end
    
  end # of class TreeViewHelper
 
end # of module FsTreeview