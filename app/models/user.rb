class User < ApplicationRecord

  before_save { username.downcase! }
  before_create { username.downcase! }
  
  validates :username, presence: true, uniqueness: true

  has_many :artworks,
    foreign_key: :artist_id
  

end