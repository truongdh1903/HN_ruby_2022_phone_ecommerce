class CartsController < ApplicationController
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
        "id": @cart.size,
        "product_detail_id": @cart_params["product_detail_id"].to_i,
        "quantity": @cart_params["quantity"].to_i,
        "checked": false
      }
    end
    reset
  end

  def minus
    return if @selected_cart["quantity"] < 2

    @selected_cart["quantity"] -= 1
    @cost = params["cost"]
    respond_to do |format|
      format.js{render :change_quantity}
    end
  end

  def plus
    @selected_cart["quantity"] += 1
    @cost = params["cost"]
    respond_to do |format|
      format.js{render :change_quantity}
    end
  end

  def check
    @selected_cart["checked"] = !@selected_cart["checked"]
    respond_to do |format|
      format.js{render :check}
    end
  end

  def destroy
    @cart_id = params[:id].to_i
    @cart.reject! do |item|
      item["id"] == params[:id].to_i
    end
    respond_to do |format|
      format.js{render :destroy}
    end
  end

  private

  def init_cart
    session[:cart] ||= []
    @cart = session[:cart]
  end

  def select_cart
    @cart.each do |item|
      @selected_cart = item if item["id"] == params[:id].to_i
    end
  end

  def cart_params
    params.require(:cart).permit :product_detail_id, :quantity
  end

  def reset
    redirect_back fallback_location: root_url
  end
end
