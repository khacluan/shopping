class LineItem < ApplicationRecord
  PurchaseTypes = {
    normal: 'normal',
    sample: 'sample',
    redeem: 'redeem',
    addon:  'addon',
  }
  enum purchase_type: PurchaseTypes

  #########################
  # RELATIONSHIPS
  belongs_to :product
  belongs_to :order

  #########################
  # VALIDATIONS
  validates :product, presence: true
  validates :purchase_type, presence: true,
    inclusion: { in: PurchaseTypes.values }
  validate :out_of_stock_validator


  #########################
  # CALLBACKS
  before_create :calculate_prices

  #########################
  # INSTANCE METHODS
  def subtotal
    self.price * self.quantity
  end

  #########################
  # PRIVATE METHODS
  private

  def calculate_prices
    # TODO calculate addon, redeem, sample price
    self.price = self.product.price
  end

  def out_of_stock_validator
    return unless quantity_changed?
    if product.available_stock < self.quantity
      errors.add(:quantity, 'not enough sotck')
    end
  end
end
