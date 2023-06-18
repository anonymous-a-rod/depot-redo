class Product < ApplicationRecord
  validates :title, :description, :image_url, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :title, uniqueness: true, length: { minimum: 10, maximum: 50}
  validates :image_url, allow_blank: true, format: {
    with: %r{\.(gif|jpeg|jpg|png)\z}i,
    message: 'Must be a URL for GIF, JPG or PNG'
  }

end
