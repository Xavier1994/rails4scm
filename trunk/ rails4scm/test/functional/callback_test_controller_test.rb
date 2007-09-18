require File.dirname(__FILE__) + '/../test_helper'
require 'callback_test_controller'

# Re-raise errors caught by the controller.
class CallbackTestController; def rescue_action(e) raise e end; end

class CallbackTestControllerTest < Test::Unit::TestCase
  def setup
    @controller = CallbackTestController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
