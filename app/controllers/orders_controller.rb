class OrdersController < ApplicationController
  before_action :check_auth

  def create
    init_order
    create_order_detail
    ActiveRecord::Base.transaction do
      @order.save!
    end
    handle_success_create_order_detail
  rescue StandardError
    handle_exception
  end

  private

  def check_auth
    return if current_user

    flash[:warning] = t "login_to_order"
    redirect_to login_url
  end

  def init_order
    @order = current_user.orders.new order_params
  end

  def order_params
    params.require(:order).permit :delivery_phone, :delivery_address,
                                  :customer_name, :note
  end

  def create_order_detail
    @cart = session[:cart]
    @cart.each do |item|
      @product_detail = ProductDetail.find_by id: item["product_detail_id"]
      @order.order_details.build(
        quantity: item["quantity"],
        cost_product: @product_detail.cost,
        product_detail_id: @product_detail.id
      )
    end
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
