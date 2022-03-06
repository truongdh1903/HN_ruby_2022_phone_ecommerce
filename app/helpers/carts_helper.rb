module CartsHelper
  def get_product_detail id
    @product_detail = ProductDetail.find_by id: id
  end

  def product_checkbox checked
    if checked
      "<input type='checkbox' class='product-checkbox checked'".html_safe
    else
      "<input type='checkbox' class='product-checkbox'".html_safe
    end
  end
end
