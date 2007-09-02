require File.dirname(__FILE__) + '/../../test_helper'
require 'framework/show_func_tree_controller'

# Re-raise errors caught by the controller.
class Framework::ShowFuncTreeController; def rescue_action(e) raise e end; end

class Framework::ShowFuncTreeControllerTest < Test::Unit::TestCase
  def setup
    @controller = Framework::ShowFuncTreeController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
