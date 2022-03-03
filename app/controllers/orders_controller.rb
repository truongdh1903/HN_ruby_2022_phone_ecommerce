class OrdersController < ApplicationController
  before_action :authenticate_user!
  authorize_resource

  def create
    init_order
    ActiveRecord::Base.transaction do
      @order.save!
      CreateOrderDetailJob.perform_now @order, session[:cart]
    end
    handle_success_create_order_detail
  rescue StandardError
    handle_exception
  end

  private

  def init_order
    @order = current_user.orders.new order_params
  end

  def order_params
    params.require(:order).permit :delivery_phone, :delivery_address,
                                  :customer_name, :note
  end

  def handle_success_create_order_detail
    flash[:success] = t "order.success"
    redirect_to root_url
  end

  def handle_exception
    flash.now[:danger] = t "error"
    redirect_back fallback_location: root_url
  end
end
