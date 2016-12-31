class OrderContents
  attr_accessor :order

  def initialize(order)
    @order = order
  end

  def add_item(product_id, quantity = 1, options={})
    options.reverse_merge!(purchase_type: LineItem::PurchaseTypes[:normal])
    item = grab_line_item_by(product_id, options)
    if item
      item.quantity += quantity
    else
      item = @order.line_items.new(product_id: product_id,
        purchase_type: options[:purchase_type],
        quantity: 1)
    end

    unless item.save
      return @order.errors.add(:line_items, item.errors.full_messages.first)
    end

    @order.calculate_total_price
    item
  end

  def remove_item(product_id, quantity = 1, options={})
    options.reverse_merge!(purchase_type: LineItem::PurchaseTypes[:normal])
    item = grab_line_item_by(product_id, options)
    return unless item
    item.quantity -= quantity
    if item.quantity.zero?
      @order.line_items.destroy(item)
    else
      item.save!
    end
    @order.calculate_total_price
    item
  end

  def total_items
    @order.line_items.map(&:quantity).sum
  end

  def subtotal
    @order.line_items.sum(&:subtotal)
  end

  private

  def grab_line_item_by(product_id, options={})
    @order.line_items.detect do |item|
      item.product_id == product_id.to_i &&
        item.purchase_type == options[:purchase_type]
    end
  end
end

