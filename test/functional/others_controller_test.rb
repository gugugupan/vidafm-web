require 'test_helper'

class OthersControllerTest < ActionController::TestCase
  test "should get qb" do
    get :qb
    assert_response :success
  end

end
