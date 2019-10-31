class User < ApplicationRecord

  before_save { username.downcase! }
  before_create { username.downcase! }
  
  validates :username, presence: true, uniqueness: true

  has_many :artworks, foreign_key: :artist_id, dependent: :destroy
  has_many :artwork_shares, foreign_key: :viewer_id, dependent: :destroy
  has_many :shared_artworks, through: :artwork_shares, source: :artwork

  
  

end