class Post < ApplicationRecord
  attachment :image
  belongs_to :user
  has_many :likes
  has_many :liked_users, through: :likes, source: :user
  has_many :comments, dependent: :destroy

  with_options presence: true do
    validates :title
    validates :body
  end
end
