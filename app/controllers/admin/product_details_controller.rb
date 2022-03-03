class Admin::ProductDetailsController < Admin::BaseController
  before_action :check_role_admin
  before_action :find_product_detail, except: %i(new create)
  before_action :check_order_details, only: :destroy

  def show; end

  def new
    if params[:product_id] &&
       (@product = Product.find_by id: params[:product_id])
      @product_detail = @product.product_details.build
    else
      handle_fail_and_render
    end
  end

  def edit; end

  def create
    @product_detail = ProductDetail.new product_detail_params
    @product_detail.image.attach params[:product_detail][:image]

    if @product_detail.save
      flash[:success] = t "admin.product_details.created_success"
      redirect_to admin_product_detail_url(@product_detail)
    else
      handle_fail_and_render :new
    end
  end

  def update
    if @product_detail.update product_detail_params
      flash[:success] = t "admin.product_details.updated_success"
      redirect_to admin_product_detail_url @product_detail
    else
      handle_fail_and_render :edit
    end
  end

  def destroy
    product = @product_detail.product
    if @product_detail.destroy
      flash[:success] = t "admin.product_details.destroyed_success"
      redirect_to admin_product_url product
    else
      handle_fail_and_render
    end
  end

  private
  def find_product_detail
    return if @product_detail = ProductDetail.find_by(id: params[:id])

    handle_fail_and_render
  end

  def product_detail_params
    params.require(:product_detail).permit ProductDetail::PRODUCT_DETAIL_ATTRS
  end

  def handle_fail_and_render page = nil
    flash[:danger] = t "admin.product_details.fail_product_detail"
    if page
      render page
    else
      redirect_to root_url
    end
  end

  def check_order_details
    return if @product_detail.order_details.blank?

    flash[:danger] = t "admin.product_details.has_ordered"
    redirect_to admin_product_path @product_detail.product
  end
end
