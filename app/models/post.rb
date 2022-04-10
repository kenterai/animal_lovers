class Post < ApplicationRecord
  validates :image, presence: true
  validates :text, presence: true

  belongs_to :category
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_one_attached :image

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
