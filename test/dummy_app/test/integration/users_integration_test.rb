require 'test_helper'

class UsersIntegrationTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test 'it' do
    get "/users/#{@user.id}"
    assert_response :success
  end
end
