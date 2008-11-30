require 'test/unit'
require 'fs_tabpanel'

class FsTabpanelTest < Test::Unit::TestCase
  include FsTabPanel
  def test_this_plugin
    puts tab_begin(['����','tokoy',false,'����','roman',true,'�����','itali',false],'one',nil);
    
      puts  tabpage_begin('tokoy',true);
      puts "this is page 1 content \r\n\r\n\r\n\r\n\r\n"
      puts tabpage_end;

      puts  tabpage_begin("roman",false);
      puts "this is page 2 content \r\n\r\n\r\n\r\n\r\n"
      puts  tabpage_end;

      puts  tabpage_begin("itali",false);
      puts "this is page 3 content \r\n\r\n\r\n\r\n\r\n"
      puts  tabpage_end;

    puts  tab_end()
  end
end
