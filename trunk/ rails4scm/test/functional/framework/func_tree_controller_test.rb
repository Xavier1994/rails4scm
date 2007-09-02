require File.dirname(__FILE__) + '/../../test_helper'
require 'framework/func_tree_controller'

# Re-raise errors caught by the controller.
class Framework::FuncTreeController; def rescue_action(e) raise e end; end

class Framework::FuncTreeControllerTest < Test::Unit::TestCase
  def setup
    @controller = Framework::FuncTreeController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
