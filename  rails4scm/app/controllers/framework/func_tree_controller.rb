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

public 
  def show()
     @tree=get_tree()
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
=begin      
      if session[:tree] ==nil then
        session[:tree] =get_tree()
        session[:tree_state]=FsTreeModel::TreeviewState.new()
      end  

     @tree=session[:tree] 
     @tree_sate=session[:tree_state]
=end     
     # p @tree
     # p @tree_sate
  end
end
