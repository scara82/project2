class User < ActiveRecord::Base
  has_secure_password

  has_many :posts
  has_many :users_ratings
  has_many :chat
end
