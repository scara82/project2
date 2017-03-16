class Chat < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  has_many :user
  has_many :post
end
