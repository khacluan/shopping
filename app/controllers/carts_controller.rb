class CartsController < ApplicationController
  before_action :require_xhr, only: [:add_item, :remove_item]

  def add_item
    @item = current_order.contents.add_item(params[:product_id], params[:quantity] || 1)
  end

  def remove_item
    @item = current_order.contents.remove_item(params[:product_id], params[:quantity] || 1)
  end

  def add_discount
    current_order.contents.add_discount(params[:discount_code])
  end

  def remove_discount
    current_order.contents.remove_discount(params[:discount_code])
  end
end

