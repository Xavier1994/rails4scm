module FsTreeModel
# ��Ӧһ��treeview��ģ�ͣ��ڲ������ڶ��Ӷ���Ҳ��treeview���ͣ�  
       class Treeview
          attr_accessor :id,:value,:url,:label,:target,:icon,:openIcon
          attr_reader :children, :parent
          
          def initialize(lbl,url="",id=nil,value=nil,target='main',icon=nil,openIcon=nil)
            @id=id
            @label = lbl ;            @value = value;            @url = url 
            @target=target;       @icon=icon;                  @openIcon=openIcon
            @parent=nil;            @children =[]
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
        end
 
# treeview �����״̬��չ������ѡ�У���ǰ�ڵ�� 
       class  TreeviewState
           attr_accessor  :currentNodeId
           attr_reader  :expandedIds, :checkedIds
           
           def resetState()
               @expandedIds=[];
               @checkedIds=[];
               @currentNodeId =nil;
           end

           def initialize()   
              resetState();
           end      
 
           def nodeExpanded?(id)
              nodeId==nil ? false : @expandedIds.include?(id);
           end

           def nodeChecked?(id)
              nodeId==nil ? false : @checkedIds.include?(id);
           end
            
           def expand(id)
              if id==nil then return end
              if not @expandedIds.include?(id) then @expandedIds<<id  end
              @currentNodeId=id
           end
            
            def collapse(id)
                if id==nil then return end
                if @expandedIds.include?(id) then @expandedIds.delete(id)  end
                @currentNodeId=id
            end
            
            def check(id)
              if id==nil then return end
              if not @checkedIds.include?(id) then @checkedIds<<id  end
              @currentNodeId=id
            end
            
            def uncheck(id)
                if id==nil then return end
                if @checkedIds.include?(id) then @checkedIds.delete(id)  end
                @currentNodeId=id
            end
        end
        
 # treeview������״̬����϶���
       class  TreeviewModel
 # ���캯����  ���treeState����Ϊ�գ����Զ����� TreeSate����
          def initialize(treeview,treeState=nil)
             if (treeview==nil) or (not treeview.is_a?(Treeview))  then
                raise 'must use a Treeview object to initilize a TreeViewModel'
             else
                @tree=treeview
                if treeState==nil
                   @state=TreeSate.new()
                else
                  @state=treeState
                end
            end
          end
            
          def getTree()
             if @tree==nil then @tree=new Treeview("root") end
             return @tree
           end
           
          def getState()
            return @state
          end
        end

# treview ��ص��¼�����ѡ�У�˫����
        class TreeviewEvent   
#Ԥ������¼�          
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
           end
           
end