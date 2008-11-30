require 'test/unit'
require 'fs_tabpanel'

class FsTabpanelTest < Test::Unit::TestCase
  include FsTabPanel
  def test_this_plugin
    p tab_begin(['东京','tokoy',false,'罗马','roman',true,'意大利','itali',false],'one',nil);
    p tabpage_begin('tokoy',true);
    p tabpage_end;

    p tabpage_begin('roman',false);
    p tabpage_end;

    p tabpage_begin('itali',false);
    p tabpage_end;

  end
end
