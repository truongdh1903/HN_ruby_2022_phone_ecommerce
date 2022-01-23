class ProductsController < ApplicationController
  def index
    @products = Product.order_created_at
    filtering_params(params).each do |key, value|
      if is_valid_param? value
        @products = @products.public_send "filter_by_#{key}", value
      end
    end
    @products = @products.search params[:key] if params[:key].present?
    @pagy, @products = pagy @products

    add_filter_options
  end

  private
  def filtering_params params
    params.slice :product_color_id, :product_size_id, :max_cost, :min_cost
  end

  def add_filter_options
    @categories = Category.all
    @product_sizes = ProductSize.all
    @product_colors = ProductColor.all
    @max_costs =
      create_custom_options_costs Settings.max_costs_million, t(".less")
    @min_costs =
      create_custom_options_costs Settings.min_costs_million, t(".more")
  end

  def is_valid_param? param
    param.present? && param != Settings.default_option_all.to_s
  end
end
