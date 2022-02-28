class Post < ApplicationRecord

  validates :image, presence: true
  validates :text, presence: true

  belongs_to :category
  belongs_to :user

  has_one_attached :image

end
