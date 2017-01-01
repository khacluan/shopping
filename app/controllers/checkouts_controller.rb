class CheckoutsController < ApplicationController
  before_action :authenticate_user!

  def delivery
  end

  def submit_delivery
    if current_order.update(delivery_params)
      redirect_to payment_checkout_path
    else
      render :delivery
    end
  end

  def payment

  end

  def submit_payment

  end

  private

  def delivery_params
    params.require(:order).permit(:name, :street, :phone, :country_id, :city_id,
                                 :district_id, :ward_id, :note)
  end
end

