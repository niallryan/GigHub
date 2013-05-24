# Treehouse (2013) Building Social Features in Ruby on Rails. [online]
# Available at: http://teamtreehouse.com/library/programming/building-social-features-in-ruby-on-rails [Accessed: 23 May 2013].

require 'test_helper'

class AddAFriendTest < ActionDispatch::IntegrationTest
  def sign_in_as(user,password)
    post login_path, user: { email: user.email, password: password }
  end
  test "that adding a friend works" do
    sign_in_as users(:niall), "testing"

    get "/user_friendships/new?friend_id=#{users(:emma).profile_name}"
    assert_response :success

    assert_difference 'UserFriendship.count', 2 do
      post "/user_friendships", user_friendship: { friend_id: users(:emma).profile_name }
      assert_response :redirect
      assert_equal "Friend request sent.", flash[:success]
    end
  end
end
