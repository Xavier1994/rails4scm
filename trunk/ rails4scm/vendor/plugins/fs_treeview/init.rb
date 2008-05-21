#扩展2种TREE标签
ActionView::Base.send( :include, FsTreeview)

#扩展回调CONTROLLER方法
require 'fs_tree_callback_controller_ext'
