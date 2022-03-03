class Admin::StaticPagesController < Admin::BaseController
  authorize_resource class: false
  def home
    @group_product_and_quantity = Product.group_quantity
    @group_cost_product_and_products = Product.group_cost_product
    @group_product_and_revenue = Product.group_revenue

    @group_status_orders = Order.group_status
    @group_shiped_date_orders = Order.group_shiped_date

    @group_confirmed_at_user = User.group_confirmed_at
  end
end
