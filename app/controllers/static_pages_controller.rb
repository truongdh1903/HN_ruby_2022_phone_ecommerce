class StaticPagesController < ApplicationController
  include StaticPagesHelper
  before_action :authenticate_user!, only: :checkout
  before_action :init_cart, only: %i(cart checkout)

  def home
    @products_suggest = Product.top_sellers Settings.number_of_suggest
    @top_new = Product.top_new Settings.number_of_top
    @top_sellers = Product.top_sellers Settings.number_of_top
    @top_rates = Product.top_rates Settings.number_of_top
  end

  def cart; end

  def checkout
    @checkout_cart = @cart.select do |item|
      item["checked"]
    end
    @total = @checkout_cart.reduce(0) do |total, item|
      total + item["quantity"] * get_product_detail(item["product_detail_id"])
                                 .cost
    end
  end

  def shop; end

  def history
    @orders = current_user.orders
  end

  private
  def init_cart
    session[:cart] ||= []
    @cart = session[:cart]
  end
end
