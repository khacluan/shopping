class OrderContents
  attr_accessor :order

  def initialize(order)
    @order = order
  end

  def add_item(product_id, quantity = 1, options={})
    options.reverse_merge!(purchase_type: LineItem::PurchaseTypes[:normal])
    item = @order.line_items.find_or_initialize_by(product_id: product_id, purchase_type: options[:purchase_type])
    item.quantity += quantity

    if item.save
      @order.calculate_total_price
      item
    else
      @order.errors.add(:line_items, item.errors.full_messages.first)
    end
  end

  def remove_item(product_id, quantity = 1)
    item = @order.line_items.find_by(product_id: product_id)
    return unless item
    if item.quantity.to_i <= quantity
      item.destroy
    else
      item.quantity -= quantity
      item.save
    end
    @order.calculate_total_price
    item
  end

  def total_items
    @order.line_items.map(&:quantity).sum
  end
end

