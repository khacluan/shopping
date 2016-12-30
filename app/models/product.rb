class Product < ApplicationRecord
  has_attached_file :image, styles: {
    square: '290x290#',
    medium: "300x300>",
    thumb: "100x100>",
  }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  has_many :line_items, dependent: :destroy
  has_many :pictures, as: :imageable, dependent: :destroy

  def available_stock
    self.stock - reserved_stock
  end

  def reserved_stock
    line_items.joins(:order).where(orders: { id: Order.paid.pluck(:id) }).sum(:quantity)
  end
end

