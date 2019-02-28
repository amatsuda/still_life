require 'test_helper'

class UsersTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test 'it' do
    get "/users/#{@user.id}"
    assert_response :success
  end
end
