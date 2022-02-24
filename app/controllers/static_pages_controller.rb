class StaticPagesController < ApplicationController
  before_action :authenticate_user!, only: :checkout
  before_action :init_cart, only: %i(cart checkout)

  def home
    @products_suggest = Product.top_sellers Settings.number_of_suggest
    @top_new = Product.top_new Settings.number_of_top
    @top_sellers = Product.top_sellers Settings.number_of_top
    @top_rates = Product.top_rates Settings.number_of_top
  end

  def cart; end

  def checkout; end

  def shop; end

  private
  def init_cart
    session[:cart] ||= []
    @cart = session[:cart]
  end
end
