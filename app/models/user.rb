class User < ApplicationRecord

  before_save { username.downcase! }
  validates :username, presence: true, uniqueness: true

  has_many :artworks,
    foreign_key: :artist_id
  

end