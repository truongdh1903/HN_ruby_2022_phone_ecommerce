class CartsController < ApplicationController
  authorize_resource
  before_action :init_cart
  before_action :select_cart, except: :create

  def new; end

  def create
    @cart_params = params[:cart]
    @cart.each do |item|
      if item["product_detail_id"] == @cart_params["product_detail_id"].to_i
        @cur_item = item
        break
      end
    end
    if @cur_item.present?
      @cur_item["quantity"] += @cart_params["quantity"].to_i
    else
      @cart << {
        "product_detail_id": @cart_params["product_detail_id"].to_i,
        "quantity": @cart_params["quantity"].to_i
      }
    end
    reset
  end

  def minus
    @selected_cart["quantity"] -= 1
    reset
  end

  def plus
    @selected_cart["quantity"] += 1
    reset
  end

  def destroy
    @cart.reject! do |item|
      item["product_detail_id"] == params[:product_detail_id].to_i
    end
    reset
  end

  private

  def init_cart
    session[:cart] ||= []
    @cart = session[:cart]
  end

  def select_cart
    @cart.each do |item|
      if item["product_detail_id"] == params[:product_detail_id].to_i
        @selected_cart = item
      end
    end
  end

  def cart_params
    params.require(:cart).permit :product_detail_id, :quantity
  end

  def reset
    redirect_back fallback_location: root_url
  end
end
