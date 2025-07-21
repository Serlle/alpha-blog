require "test_helper"
require 'pry'

class CreateUserTest < ActionDispatch::IntegrationTest
  test "get user form and create user" do
    get "/signup/"
    assert_response :success
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { username: "name", email: "name@example.com", password: "password", admin: true } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "name", response.body
  end 

  test "get new user form and reject invalid username" do
    get "/signup/"
    assert_response :success
    assert_no_difference 'User.count' do
      post users_path, params: { user: { username: " ", email: "email@example.com", password: "password", admin: true } }
    end
    assert_match "errors", response.body
    assert_select 'div.alert'
  end

  test "get new user form and reject invalid email" do
    get "/signup/"
    assert_response :success
    assert_no_difference 'User.count' do
      post users_path, params: { user: { username: "name", email: "format-error", password: "password", admin: true  } }
    end

    assert_match "errors", response.body
    assert_select 'div.alert'
  end
end
