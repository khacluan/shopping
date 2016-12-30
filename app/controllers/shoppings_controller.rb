class ShoppingsController < ApplicationController
  def index
    @hottest_products = Product.order(created_at: :desc).limit(9)
  end
end
