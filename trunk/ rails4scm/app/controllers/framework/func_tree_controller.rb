require 'fs_tree_model'

class Framework::FuncTreeController < ApplicationController

private
   def get_tree()
      inst=FsTreeModel::Treeview.new("root","#",0,'mainvalue')
      sub1=FsTreeModel::Treeview.new("HTML方式的功能树","/framework/func_tree/tree",1,'value1')
      sub2=FsTreeModel::Treeview.new("使用JS的功能树","/framework/func_tree",2,'value2')
      sub3=FsTreeModel::Treeview.new("功能3","#",3,'value3')
      sub11=FsTreeModel::Treeview.new("功能11","http://www.forallsoft.com",11,'value11')
      sub12=FsTreeModel::Treeview.new("新浪网","http://www.sina.com.cn",12,'value12')
      sub21=FsTreeModel::Treeview.new("功能21","#",21,'value21')
      sub211=FsTreeModel::Treeview.new("功能211","http://www.baidu.com.cn",211,'value211')
      sub212=FsTreeModel::Treeview.new("功能212","/pages/framework/index.htm",212,'value212')
      
      inst<<sub1<<sub2<<sub3
      sub1<<sub11; sub1<<sub12;  sub2<<sub21
      sub21<<sub211; sub21<<sub212

      return inst
   end
   
   def getUserTree
     begin
       inst=FsTreeModel::Treeview.new("软件配置管理系统","#",0,'mainvalue')
       
       #从session中得到用户编号
       operid = session[:operator].OPER_ID

       #通过用户提取权限
       rtSystemFunction = RtSystemFunction.new()
       @rtSystemFunction = rtSystemFunction.findUserSystemFunction(operid)
       if @rtSystemFunction == nil then
          return inst
       end
       funcGroupIds = ""
       for systemFunction in @rtSystemFunction
          func_group_id = systemFunction.func_group_id 
          funcGroupIds = funcGroupIds + "'" + func_group_id + "',"
          func_group_id = nil
       end
       if funcGroupIds.length>0 then
         funcGroupIds = funcGroupIds.slice(0, funcGroupIds.length-1)
       end
       
       #通过系统功能提取功能组
       rtFunctionGroup = RtFunctionGroup.new()
       @rtFunctionGroup = rtFunctionGroup.findSystemGroup(funcGroupIds)
       if @rtFunctionGroup == nil then
          return inst
       end
       upGroupIds = ""
       for functionGroup in @rtFunctionGroup
          up_group_id = functionGroup.up_group_id
          upGroupIds = upGroupIds + "'" + up_group_id + "',"
          up_group_id = nil
       end
       if upGroupIds.length>0 then
         upGroupIds = upGroupIds.slice(0, upGroupIds.length-1)
       end
       
       #通过功能组的上级ID提取功能组
       @rtFunctionGroupUp = rtFunctionGroup.findSystemGroupUp(upGroupIds)
       if @rtFunctionGroupUp == nil then
          return inst
       end
       i=1  
       for functionGroupUp in @rtFunctionGroupUp  
         functionGroupUpName = functionGroupUp.func_group_name 
         functionGroupUpName = functionGroupUpName.split(//)[3,functionGroupUpName.length]
         functionGroupUpUrl  = functionGroupUp.url
         group_id            = functionGroupUp.func_group_id
         sub1=FsTreeModel::Treeview.new(functionGroupUpName,functionGroupUpUrl,i,'value1')
         j=1
         for functionGroup in @rtFunctionGroup
            up_group_id = functionGroup.up_group_id
            if group_id == up_group_id then
              functionGroupName = functionGroup.func_group_name 
              functionGroupUrl  = functionGroup.url
              group_id_up = functionGroup.func_group_id
              cn = i.to_s + j.to_s 
              sub2=FsTreeModel::Treeview.new(functionGroupName,functionGroupUrl,cn,'value' + cn)
              k = 1
              for systemFunction in @rtSystemFunction
                func_group_id = systemFunction.func_group_id 
                if group_id_up == func_group_id then
                  cnk = cn.to_s + k.to_s 
                  systemName = systemFunction.func_name
                  systemUrl  = systemFunction.target + systemFunction.func_param
                  sub3=FsTreeModel::Treeview.new(systemName,systemUrl,cnk,'value' + cnk)
                  cnk = ""
                  k = k + 1
                  sub2<<sub3
                end
                func_group_id = nil
              end 
              j = j+1
              cn = ""
              sub1<<sub2
              group_id_up = nil
            end
            up_group_id = nil
         end
         group_id = nil
         i = i+1
         inst<<sub1 
       end
     rescue Exception => e
       print e.backtrace.join("\n")
     end 
     return inst
   end
public 
  def show()
     #@tree=get_tree()
     @tree=getUserTree() 
  end 
  
  def index
      show()
  end
    
  def tree()
     #~ p params
    if session[:fs_treeview_helper]==nil then
      @tree=get_tree()
      @tree_state1=FsTreeModel::TreeviewState.new()
    else
      helper=session[:fs_treeview_helper]
      @tree=helper.treeViewModel
      @tree_state1=helper.treeviewState
    end   
  end
end
