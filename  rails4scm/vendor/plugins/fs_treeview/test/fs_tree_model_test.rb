require 'test/unit'
require File.dirname(__FILE__) + '/../lib/fs_tree_model'

class FsTreeModelTest < Test::Unit::TestCase
 
  include FsTreeModel
  
  class Tree <Treeview
  end 
  
  def test_treeview_item
    p 'now test treeview itself----'
    root=Tree.new("root")

    c1 = Tree.new("c1");  c2=Tree.new("c2","this is url")

    root<< c1 <<c2

    c3 =Tree.new("c1-1");    c1 << c3
#   p root 
#   puts "---"

    root.each do |v|
      puts v.label
    end 

    puts "---"

    c1.each do |v|
      puts v.label
    end

    puts "---"
    print "root--"; puts root.leaf?
    print 'c3--'; puts c3.leaf?
  end
  
  def test_TreeviewState
     p 'now test state----'
     state=TreeviewState.new()
     state.expand(2); state.check(3)
     p state
  end   
  
  def test_treeviewEvent
     p 'now test envent----'
     
     p TreeviewEvent.is_event?(TreeviewEvent::NODE_COLLAPSED|TreeviewEvent::NODE_CHECKED)
     
     p TreeviewEvent.new(TreeviewEvent::NODE_CHECKED,1,2,Treeview.new(:root)).sourceTreeviewModel
     
  end
  
  def test_treeviewModel
     p 'now test composited odel----'
     tree=Treeview.new(:root)
     state=TreeviewState.new(); state.expand(2); state.check(3)
     p TreeviewModel.new(tree,state).getState
  end
end
