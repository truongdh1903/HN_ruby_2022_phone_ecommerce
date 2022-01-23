module ApplicationHelper
  include Pagy::Frontend

  def full_title page_title
    base_title = t "base_title_page"
    page_title.blank? ? base_title : "#{page_title} | #{base_title}"
  end

  def get_avg_cost_product product
    return Settings.default_cost if product.product_details.blank?

    number_with_delimiter product.product_details.average(:cost).round,
                          delimiter: Settings.currency_break
  end
end
