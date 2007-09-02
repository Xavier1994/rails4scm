require 'test/unit'
require  'fs_treeview'
class FsTreeviewTest < Test::Unit::TestCase
   include 'FsTreeview' 
# Replace this with your real tests.
  def test_js_view
      p js_treeview_tag(nil)
  end
 
end