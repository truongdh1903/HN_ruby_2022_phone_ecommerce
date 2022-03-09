class Admin::ProductsController < Admin::BaseController
  include Admin::ProductHelper
  before_action :check_role_admin
  before_action :find_product, except: %i(index new create)
  before_action :check_product_orders, only: :destroy

  def index
    @query = Product.ransack params[:query]
    @products = @query.result.includes :product_details, :category
    @pagy, @products = pagy @products
  end

  def show
    @product_details = @product.product_details
    @pagy, @product_details = pagy @product_details
  end

  def new
    @product = Product.new
  end

  def edit; end

  def create
    @product = Product.new product_params

    if @product.save
      flash[:success] = t "admin.products.created_success"
      redirect_to admin_product_url @product
    else
      flash[:danger] = t "admin.products.fail_product"
      render :new
    end
  end

  def update
    if @product.update product_params
      flash[:success] = t "admin.products.updated_success"
      redirect_to admin_product_url @product
    else
      flash[:danger] = t "admin.products.fail_product"
      render :edit
    end
  end

  def destroy
    if @product.destroy
      flash[:success] = t "admin.products.destroyed_success"
      redirect_to admin_products_url
    else
      handle_product_fail
    end
  end

  private
  def find_product
    return if @product = Product.find_by(id: params[:id])

    handle_product_fail
  end

  def product_params
    params.require(:product).permit(
      :name,
      :desc,
      :category_id,
      product_details_attributes: ProductDetail::PRODUCT_DETAIL_ATTRS
    )
  end

  def handle_product_fail
    flash[:danger] = t "admin.products.fail_product"
    redirect_to admin_products_url
  end

  def check_product_orders
    @product.product_details.each do |product_detail|
      if product_detail.order_details.present?
        flash[:danger] = t "admin.products.ordered_product"
        return redirect_to admin_products_url
      end
    end
  end
end
