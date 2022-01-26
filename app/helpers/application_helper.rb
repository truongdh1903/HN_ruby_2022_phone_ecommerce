module ApplicationHelper
  include Pagy::Frontend

  def full_title page_title
    base_title = t "base_title_page"
    page_title.blank? ? base_title : "#{page_title} | #{base_title}"
  end

  def get_avg_cost_product product
    return display_cost(Settings.default_cost) if product.product_details.blank?

    display_cost product.product_details.average(:cost)
  end

  def display_cost cost
    t("products.index.currency_unit_front") +
      number_with_delimiter(cost.round, delimiter: Settings.currency_break) +
      t("products.index.currency_unit_back")
  end

  def get_avg_star product
    return Settings.default_star if product.rates.blank?

    product
      .rates.average(:number_of_stars).round Settings.star_round_after_comma
  end
end
