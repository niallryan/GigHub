require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should have_many(:user_friendships)
  should have_many(:friends)

  test "a user should enter a first name" do
    user = User.new
    assert !user.save
    assert !user.errors[:first_name].empty?
  end

  test "a user should enter a last name" do
    user = User.new
    assert !user.save
    assert !user.errors[:last_name].empty?
  end

  test "a user should enter a profile name" do
    user = User.new
    assert !user.save
    assert !user.errors[:profile_name].empty?
  end

  test "user should have a unique profile name" do
    user = User.new
    user.profile_name = users(:niall).profile_name
    assert !user.save
    assert !user.errors[:profile_name].empty?
  end

  test "a user should have a profile name without spaces" do
    user = User.new(first_name: 'Emma', last_name: 'Sheridan', email: 'emma@email.com')
    user.password = user.password_confirmation = 'password'

    user.profile_name = "Ha Ha Ha"

    assert !user.save
    assert !user.errors[:profile_name].empty?
    assert user.errors[:profile_name].include?("Must be formatted correctly.")
  end

  test "a user can have a correctly formatted profile name" do
    user = User.new(first_name: 'Niall', last_name: 'Ryan', email: 'niallryan@email.com')
    user.password = user.password_confirmation = 'password1'

    user.profile_name = 'niallryan1'
    assert user.valid?
  end

  test "that no error is raised when trying to access a friend list" do
    assert_nothing_raised do
      users(:niall).friends
    end
  end

  test "that creating friendships on a user works" do
    users(:niall).pending_friends << users(:maeve)
    users(:niall).pending_friends.reload
    assert users(:niall).pending_friends.include?(users(:maeve))
  end

  test "that calling to_param on a user return the profile_name" do
    assert_equal "nelsonry", users(:niall).to_param
  end

end
