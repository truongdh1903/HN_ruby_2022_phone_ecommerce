class Admin::OrdersController < Admin::BaseController
  authorize_resource
  before_action :find_order, only: %i(show edit update destroy)

  def index
    @orders = Order.order_created_at
    @pagy, @orders = pagy @orders
  end

  def show; end

  def new
    @order = Order.new
  end

  def edit; end

  def create
    @order = Order.new order_params

    if @order.save
      flash[:success] = t "admin.orders.created_success"
      redirect_to admin_order_url @order
    else
      handle_fail_and_render :new
    end
  end

  def update
    if @order.update order_params
      flash[:success] = t "admin.orders.updated_success"
      render :show
    else
      handle_fail_and_render :edit
    end
  end

  def destroy
    if @order.destroy
      flash[:success] = t "admin.orders.destroyed_success"
      redirect_to admin_orders_url
    else
      handle_fail_and_render
    end
  end

  private
  def find_order
    return if @order = Order.find_by(id: params[:id])

    handle_fail_and_render
  end

  def order_params
    params.require(:order).permit :customer_name,
                                  :delivery_address,
                                  :delivery_phone,
                                  :status,
                                  :shiped_date,
                                  :user_id,
                                  :note
  end

  def handle_fail_and_render page = nil
    flash[:danger] = t "admin.orders.fail_order"
    page ? render(page) : redirect_to(root)
  end
end
