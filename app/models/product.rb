class Product < ApplicationRecord
  has_many :line_items

  before_destroy :ensure_not_referenced_by_any_line_items

  validates :title, :description, :image_url, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :title, uniqueness: true, length: { minimum: 10, maximum: 50}
  validates :image_url, allow_blank: true, format: {
    with: %r{\.(gif|jpeg|jpg|png)\z}i,
    message: 'Must be a URL for GIF, JPG or PNG'
  }

  private

  def ensure_not_referenced_by_any_line_items
    unless line_items.empty?
      errors.add(:base, 'Line Items present')
      throw :abort
    end
  end

end
