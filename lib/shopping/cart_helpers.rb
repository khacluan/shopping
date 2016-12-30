module Shopping
  module CartHelpers
    extend ActiveSupport::Concern

    included do
      before_action :set_current_order

      helper_method :current_order
    end

    def current_order(options = {})
      return @current_order if @current_order

      @current_order = find_order_by_token_or_user(options, true)

      if @current_order.nil? || @current_order.completed?
        @current_order = Order.create!(current_order_params)
        @current_order.associate_user! current_user if current_user
      end

      if @current_order
        @current_order.ip_address = ip_address
        session[:order_id] = @current_order.id
        return @current_order
      end
    end

    def associate_user
      @order ||= current_order
      if current_user && @order && (@order.user.blank? || @order.email.blank?)
        @order.associate_user!(current_user)
      end
    end

    def set_current_order
      if current_user && current_order
        current_user.orders.incomplete.where.not(id: current_order.id).each do |order|
          current_order.merge!(order, current_user)
        end
      end
    end

    def ip_address
      request.remote_ip
    end

    private

    def last_incomplete_order
      @last_incomplete_order ||= current_user.last_incomplete_order
    end

    def current_order_params
      { ip_address: ip_address, user_id: current_user.try(:id) }
    end

    def find_order_by_token_or_user(options={}, with_adjustments = false)
      options[:lock] ||= false

      # Find any incomplete orders for the guest_token
      incomplete_orders = Order.incomplete.includes(line_items: :product)
      guest_token_order_params = current_order_params.except(:user_id)
      order = incomplete_orders.lock(options[:lock]).find_by(guest_token_order_params)

      # Find any incomplete orders for the current user
      if order.nil? && current_user
        order = last_incomplete_order
      end

      order
    end
  end
end

