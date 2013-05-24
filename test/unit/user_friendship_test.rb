# Treehouse (2013) Building Social Features in Ruby on Rails. [online]
# Available at: http://teamtreehouse.com/library/programming/building-social-features-in-ruby-on-rails [Accessed: 23 May 2013].

require 'test_helper'

class UserFriendshipTest < ActiveSupport::TestCase
  should belong_to (:user)
  should belong_to (:friend)

  test "that creating a friendship works without raising an exception" do
    assert_nothing_raised do
      UserFriendship.create user: users(:niall), friend: users(:maeve)
    end
  end

  test "that creating a friendship based on user id and friend id works" do
    UserFriendship.create user_id: users(:niall).id, friend_id: users(:maeve).id
    assert users(:niall).pending_friends.include?(users(:maeve))
  end

  context "a new instance" do
    setup do
      @user_friendship = UserFriendship.new user: users(:niall), friend: users(:maeve)
    end

    should "have a pending state" do
      assert_equal 'pending', @user_friendship.state
    end
  end

  context "#send_request_email" do
    setup do
      @user_friendship = UserFriendship.create user: users(:niall), friend: users(:maeve)
    end

    should "send an email" do
      assert_difference 'ActionMailer::Base.deliveries.size', 1 do
        @user_friendship.send_request_email
      end
    end
  end

  context "#mutual_friendship" do
    setup do
      UserFriendship.request users(:niall), users(:emma)
      @friendship1 = users(:niall).user_friendships.where(friend_id: users(:emma).id).first
      @friendship2 = users(:emma).user_friendships.where(friend_id: users(:niall).id).first
    end

    should "correctly find the mutual friendship" do
      assert_equal @friendship2, @friendship1.mutual_friendship
    end

  end

  context "#accept_mutual_friendship!" do
    setup do
      UserFriendship.request users(:niall), users(:emma)
    end

    should "accept the mutual friendship" do
      friendship1 = users(:niall).user_friendships.where(friend_id: users(:emma).id).first
      friendship2 = users(:emma).user_friendships.where(friend_id: users(:niall).id).first

      friendship1.accept_mutual_friendship!
      friendship2.reload
      assert_equal 'accepted', friendship2.state
    end
  end

  context "#accept!" do
    setup do
      @user_friendship = UserFriendship.request users(:niall), users(:maeve)
    end

    should "set the state to accepted" do
      @user_friendship.accept!
      assert_equal "accepted", @user_friendship.state
    end

    should "send an acceptance mail" do
      assert_difference 'ActionMailer::Base.deliveries.size', 1 do
        @user_friendship.accept!
      end
    end

    should "include the friend in the list of friends" do
      @user_friendship.accept!
      users(:niall).friends.reload
      assert users(:niall).friends.include?(users(:maeve))
    end

    should "accept the mutual friendship" do
      @user_friendship.accept!
      assert_equal 'accepted', @user_friendship.mutual_friendship.state
    end

  end

  context ".request" do
    should "create two user friendships" do
      assert_difference 'UserFriendship.count', 2 do
        UserFriendship.request(users(:niall), users(:maeve))
      end
    end

    should "send a friend request email" do
      assert_difference 'ActionMailer::Base.deliveries.size', 1 do
        UserFriendship.request(users(:niall), users(:maeve))
      end
    end
  end

  context "#delete_mutual_friendship!" do
    setup do
      UserFriendship.request users(:niall), users(:emma)
      @friendship1 = users(:niall).user_friendships.where(friend_id: users(:emma).id).first
      @friendship2 = users(:emma).user_friendships.where(friend_id: users(:niall).id).first
    end
    should "delete the mutual friendship" do
      assert_equal @friendship2, @friendship1.mutual_friendship
      @friendship1.delete_mutual_friendship
      assert !UserFriendship.exists?(@friendship2.id)
    end
  end

  context "on destroy" do
    setup do
      UserFriendship.request users(:niall), users(:emma)
      @friendship1 = users(:niall).user_friendships.where(friend_id: users(:emma).id).first
      @friendship2 = users(:emma).user_friendships.where(friend_id: users(:niall).id).first
    end

    should "delete the mutual friendship" do
      @friendship1.destroy
      assert !UserFriendship.exists?(@friendship2.id)
    end
  end

end
