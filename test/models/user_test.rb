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
    @user1 = User.create!(username: "fuzzywuzzy")
    @user2 = User.create!(username: "barfoo")
    @artwork1 = Artwork.create!(title: 'Food Bar', image_url: 'google.com', artist_id: @user1.id)
    ArtworkShare.create!(artwork_id: @artwork1.id, viewer_id: @user2.id)
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

  test "User#shared_artworks returns a set of artworks that has been shared with the user" do
    shared_art_set = @user2.shared_artworks

    assert_not shared_art_set.empty?
  end

end
