require File.dirname(__FILE__) + '/../../test_helper'
require 'framework/logcheck_controller'

# Re-raise errors caught by the controller.
class Framework::LogcheckController; def rescue_action(e) raise e end; end

class Framework::LogcheckControllerTest < Test::Unit::TestCase
  def setup
    @controller = Framework::LogcheckController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
