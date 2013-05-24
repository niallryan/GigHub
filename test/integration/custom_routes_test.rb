# Treehouse (2013) Building Social Features in Ruby on Rails. [online]
# Available at: http://teamtreehouse.com/library/programming/building-social-features-in-ruby-on-rails [Accessed: 23 May 2013].

require 'test_helper'

class CustomRoutesTest < ActionDispatch::IntegrationTest

  test "that /login route opens the login page" do
    get '/login'
    assert_response :success
  end

  test "that /logout route opens log out page" do
    get '/logout'
    assert_response :redirect
    assert_redirected_to '/'
  end

  test "that /register route opens the registration page" do
    get '/register'
    assert_response :success
  end

  test "that a profile page works" do
    get '/emmaemma'
    assert_response :success
  end

end
