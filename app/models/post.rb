class Post < ApplicationRecord

  validates :image, presence: true
  validates :text, presence: true

  belongs_to :category
  belongs_to :user

  has_one_attached :image

  def get_image(width, height)
    image.variant(resize_to_limit: [width, height]).processed
  end

end
