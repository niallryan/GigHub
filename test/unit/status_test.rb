# Treehouse (2013) Building Social Features in Ruby on Rails. [online]
# Available at: http://teamtreehouse.com/library/programming/building-social-features-in-ruby-on-rails [Accessed: 23 May 2013].

require 'test_helper'

class StatusTest < ActiveSupport::TestCase

  test "that a status requires content" do
    status = Status.new
    assert !status.save
    assert !status.errors[:content].empty?
  end

  test "that a status's content is at least 2 letters long" do
    status = Status.new
    status.content = "H"
    assert !status.save
    assert !status.errors[:content].empty?
  end

  test "that a status has a user id" do
    status = Status.new
    status.content = "Hello"
    assert !status.save
    assert !status.errors[:user_id].empty?
  end

end
