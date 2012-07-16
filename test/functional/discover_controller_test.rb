require 'test_helper'

class DiscoverControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get star" do
    get :star
    assert_response :success
  end

end
