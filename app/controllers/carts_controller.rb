class CartsController < ApplicationController
  before_action :require_xhr, only: [:add_item, :remove_item]

  def add_item
    current_order.contents.add_item(params[:product_id], params[:quantity] || 1)
    render :cart_change
  end

  def remove_item
    current_order.contents.remove_item(params[:product_id], params[:quantity] || 1)
    render :cart_change
  end

  def add_discount
    current_order.contents.add_discount(params[:discount_code])
    render :cart_change
  end

  def remove_discount
    current_order.contents.remove_discount(params[:discount_code])
    render :cart_change
  end
end

