class StaticPagesController < ApplicationController
  def home
    @products_suggest = Product.top_sellers Settings.number_of_suggest
    @top_new = Product.top_new Settings.number_of_top
    @top_sellers = Product.top_sellers Settings.number_of_top
    @top_rates = Product.top_rates Settings.number_of_top
  end

  def cart
    @cart = session[:cart]
  end

  def checkout; end

  def shop; end
end
