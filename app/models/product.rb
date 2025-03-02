class Product < ApplicationRecord
  has_many :line_items

  before_destroy :ensure_not_referenced_by_line_item

  validates :title, :description, :image_url, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: {
    with: /\.(gif|jpg|png)\z/i,
    message: 'はGIF、JPG、PNG画像のURLでなければなりません'
  }

  private
  def ensure_not_referenced_by_line_item
    if line_items.empty?
      return true
    else
      errors.add(:base, '品目が存在します')
      return false
    end
  end
end
