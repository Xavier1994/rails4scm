module FsTreeModel
# 对应一个treeview的模型，内部包含众多子对象（也是treeview类型）  
       class Treeview
          attr_accessor :id,:value,:url,:label,:target,:icon,:openIcon
          attr_reader :children, :parent
          
          def initialize(lbl,url="",id=nil,value=nil,target='main',icon=nil,openIcon=nil)
            @id=id
            @label = lbl ;            @value = value;            @url = url 
            @target=target;       @icon=icon;                  @openIcon=openIcon
            @parent=nil;            @children =[]    #约定根结点的parent＝nil
          end  
          
          def parent=(parent)
               if not parent.is_a?(Treeview)
                  raise 'call to parent= of Treeview, param must be of type Treeview '
               else
                 @parent=parent
               end
          end
          
          def leaf?()
            return @children.empty?
          end
          
          def <<(child)
            if not child.is_a?(Treeview)
              raise 'Treeview\'s insertion oprerator << only accept Treeview as parameter'
            else
              @children<<child
              child.parent=self
            end
          end
          
          def each
            @children.each{|child| yield child}
          end 
          
#判定是否本级别的最后一节点         
          def lastNodeThisLevel?()
             if @parent==nil then return true end
             return self==@parent.children.last()
          end
          
 #getNodeById         
          def [](nodeId)
             if nodeId==@id then
                return self
            else
                @children.each{|child| if(nodeId==child.id) then return  child end }
            end
            return nil  
          end   # of operator [] 
       end # of class Treeview
 
# treeview 对象的状态，展开，被选中，当前节点等 
       class  TreeviewState
           attr_accessor  :currentNodeId,:model
           attr_reader  :expandedIds, :checkedIds
           
           def resetState()
               @expandedIds=[];
               @checkedIds=[];
               @currentNodeId =nil;
           end

           def initialize()   
              resetState()
           end      
 
           def nodeExpanded?(id)
              id==nil ? false : @expandedIds.include?(id.to_s);
           end

           def nodeChecked?(id)
              id==nil ? false : @checkedIds.include?(id.to_s);
           end
            
           def expand(id)
              if id==nil then return end
              if not @expandedIds.include?(id.to_s) then @expandedIds<<id.to_s  end
              @currentNodeId=id
           end
            
            def collapse(id)
                if id==nil then return end
                if @expandedIds.include?(id.to_s) then @expandedIds.delete(id.to_s)  end
                @currentNodeId=id
            end
            
            def check(id)
              if id==nil then return end
              if not @checkedIds.include?(id.to_s) then @checkedIds<<id.to_s  end
              @currentNodeId=id
            end
            
            def uncheck(id)
                if id==nil then return end
                if @checkedIds.include?(id.to_s) then @checkedIds.delete(id.to_s)  end
                @currentNodeId=id
            end
        end # of class  TreeviewState
        
# treview 相关的事件，如选中，双击等
        class TreeviewEvent   
#预定义的事件 
            SELECTION_CHANGED     = 1;
            NODE_EXPANDED           = 2;
            NODE_COLLAPSED          = 4;
            NODE_CHECKED             = 8;
            NODE_UNCHECKED          = 16;
            SELECT_AGAIN              =32;

            attr_accessor  :sourceTreeviewModel
            attr_reader  :eventType, :nodeId, :nodeValue
          
            def initialize(eventType, nodeId ,nodeValue,sourceTreeviewModel)
               @eventType=eventType;
               @nodeId=nodeId;   @nodeValue=nodeValue;
               @sourceTreeviewModel=sourceTreeviewModel
             end  
             
             def self.is_event?(event)
                 allEvent=SELECTION_CHANGED|NODE_EXPANDED|NODE_COLLAPSED|NODE_CHECKED|NODE_UNCHECKED|SELECT_AGAIN
                 return (allEvent & event) > 0
             end
      end # of class  TreeviewEvent
end # of FsTreeModel

 #~ # treeview对象及其状态的组合对象
       #~ class  TreeviewModel
 #~ # 构造函数，  如果treeState参数为空，则自动创建 TreeSate对象
          #~ def initialize(treeview,treeState=nil)
             #~ if (treeview==nil) or (not treeview.is_a?(Treeview))  then
                #~ raise 'must use a Treeview object to initilize a TreeViewModel'
             #~ else
                #~ @tree=treeview
                #~ if treeState==nil
                   #~ @state=TreeSate.new()
                #~ else
                  #~ @state=treeState
                #~ end
            #~ end
          #~ end
            
          #~ def getTree()
             #~ if @tree==nil then @tree=new Treeview("root") end
             #~ return @tree
           #~ end
           
          #~ def getState()
            #~ return @state
          #~ end
        #~ end
