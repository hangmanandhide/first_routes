require 'test_helper'
require "minitest/reporters"
Minitest::Reporters.use!
require 'byebug'

class ArtworkShareTest < ActiveSupport::TestCase

  def setup
    @user1 = User.create!(username: "fuzzywuzzy")
    @user2 = User.create!(username: "barfoo")
    @artwork1 = Artwork.create!(title: 'Food Bar', image_url: 'google.com', artist_id: @user1.id)
    ArtworkShare.create!(artwork_id: @artwork1.id, viewer_id: @user2.id)
  end


  test "should have a single artwork shared once per user" do

    shared_again = ArtworkShare.new(artwork_id: @artwork1.id, viewer_id: @user2.id)

    assert_not shared_again.valid?
  end


end
