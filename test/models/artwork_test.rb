require 'test_helper'
require "minitest/reporters"
Minitest::Reporters.use!
require 'byebug'

class ArtworkTest < ActiveSupport::TestCase

  
def setup
    @user1 = User.create!(username: "fuzzywuzzy")
    @user2 = User.create!(username: "barfoo")
    @artwork1 = Artwork.new(title: 'Food Bar', image_url: 'google.com', artist_id: @user1.id)
  end

  test "should be valid" do
    assert @artwork1.valid?
  end

  test "title should be present" do
    @artwork1.title = "        "
    assert_not @artwork1.valid?
  end

  test "image_url should be present" do
    @artwork1.image_url = "        "
    assert_not @artwork1.valid?
  end

  test "artist_id should be present" do
    @artwork1.artist_id = "        "
    assert_not @artwork1.valid?
  end

  test "Artwork titles should occur once per artist" do
    original_artwork = @artwork1.dup
    original_artwork.save
    duplicate_artwork = Artwork.new(title: 'Food Bar', image_url: 'google1.com', artist_id: @user1.id)


    assert_not duplicate_artwork.valid?
  end


end
