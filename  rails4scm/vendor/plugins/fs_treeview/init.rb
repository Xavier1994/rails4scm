# Include hook code here

require 'fs_tree_actioncontroller_ext'
require 'fs_tree_route_ext'

ActionView::Base.send( :include, FsTreeview)