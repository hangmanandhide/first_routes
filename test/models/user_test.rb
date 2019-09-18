require 'test_helper'
require "minitest/reporters"
Minitest::Reporters.use!
require 'byebug'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end


  def setup
    @user = User.new(username: "FOOBAR")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "username should be present" do
    @user.username = "        "
    assert_not @user.valid?
  end

  test "username should be unique" do
    original_user = @user.dup
    original_user.save
    duplicate_user = User.new(username: "foobar")


    assert_not duplicate_user.valid?
  end

end
