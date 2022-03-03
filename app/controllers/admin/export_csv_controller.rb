class Admin::ExportCsvController < Admin::BaseController
  def new
    @products = Product.order_created_at.eager_load(:category)
    @orders = Order.order_created_at.eager_load(:user)
    respond_to do |format|
      format.xls
    end
  end
end
