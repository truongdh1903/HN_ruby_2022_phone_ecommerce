module CartsHelper
  def get_product_detail id
    @product_detail = ProductDetail.find_by id: id
  end
end
