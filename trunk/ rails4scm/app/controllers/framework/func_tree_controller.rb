require 'fs_tree_model'

class Framework::FuncTreeController < ApplicationController

private
   def get_tree()  
      inst=FsTreeModel::Treeview.new("root","#")
      sub1=FsTreeModel::Treeview.new("HTML��ʽ�Ĺ�����","/framework/func_tree/tree")
      sub2=FsTreeModel::Treeview.new("ʹ��JS�Ĺ�����","/framework/func_tree")
      sub3=FsTreeModel::Treeview.new("����3","#")
      sub11=FsTreeModel::Treeview.new("����11","http://www.forallsoft.com")
      sub12=FsTreeModel::Treeview.new("������","http://www.sina.com.cn")
      sub21=FsTreeModel::Treeview.new("����21","#")
      sub211=FsTreeModel::Treeview.new("����211","http://www.baidu.com.cn")
      sub212=FsTreeModel::Treeview.new("����212","/pages/framework/index.htm")
      
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
     if session[:tree] ==nil then
        session[:tree] =get_tree()
        session[:tree_state]=FsTreeModel::TreeviewState.new()
      end  

     @tree=session[:tree] 
     @tree_sate=session[:tree_state]
     
     #~ p @tree
     #~ p @tree_sate
  end
end
