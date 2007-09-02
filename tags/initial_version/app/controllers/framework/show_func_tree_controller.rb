require 'fs_tree_model'

class Framework::ShowFuncTreeController < ApplicationController

private
   def get_tree()
      inst=FsTreeModel::Treeview.new("root","#")
      sub1=FsTreeModel::Treeview.new("����1","http://www.sina.com.cn")
      sub2=FsTreeModel::Treeview.new("����2","/framework/show_func_tree")
      sub3=FsTreeModel::Treeview.new("����3","#")
      sub11=FsTreeModel::Treeview.new("����11","http://www.sina.com.cn")
      sub12=FsTreeModel::Treeview.new("����12","/framework/show_func_tree")
      sub21=FsTreeModel::Treeview.new("����21","#")
      sub211=FsTreeModel::Treeview.new("����211","http://www.baidu.com.cn")
      sub212=FsTreeModel::Treeview.new("����212","/pages/framework/index.htm")
      
      inst<<sub1<<sub2<<sub3
      sub1<<sub11; sub1<<sub12;  sub2<<sub21
      sub21<<sub211; sub21<<sub212

      return inst
   end

public  
  def index
     @tree=get_tree()
   end
end
