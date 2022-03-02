class CreateOrderDetailJob < ApplicationJob
  queue_as :default

  def perform order, cart
    @order = order
    cart.each do |item|
      @product_detail = ProductDetail.find_by id: item["product_detail_id"]
      @order.order_details.build(
        quantity: item["quantity"],
        cost_product: @product_detail.cost,
        product_detail_id: @product_detail.id
      )
    end
    @order.save
  end
end
