require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    prep_objects
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

end
