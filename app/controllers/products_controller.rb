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

  def show
    @product = Product.includes(:product_details).find_by id: params[:id]
    if @product && exists_product_details?
      @pagy, @comments = pagy @product.comments.order_created_at,
                              items: Settings.size_comments_product
      @comment = @product.comments.build
      create_entities_show_page
    else
      flash[:danger] = t ".invalid_address"
      redirect_to root_url
    end
  end

  private
  def exists_product_details?
    @product.product_details.exists?
  end

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

  def create_entities_show_page
    @product_detail = if params[:product_detail_id].present?
                        @product.product_details
                                .find_by id: params[:product_detail_id]
                      else
                        @product.product_details.first
                      end
    @products_suggest = @product.category.products
                                .top_sellers Settings.number_of_suggest
  end

  def is_valid_param? param
    param.present? && param != Settings.default_option_all.to_s
  end
end
