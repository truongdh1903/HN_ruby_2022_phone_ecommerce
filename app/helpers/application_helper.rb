module ApplicationHelper
  include Pagy::Frontend

  def full_title page_title
    base_title = t "base_title_page"
    page_title.blank? ? base_title : "#{page_title} | #{base_title}"
  end

  def toastr_flash
    flash_messages = ""
    flash.each do |type, message|
      case type
      when "alert", "danger" then type = "error"
      when "success" then type = "notice"
      end

      flash_messages << "toastr.#{type}('#{message}');" if message
    end
    javascript_tag flash_messages
  end

  def get_avg_cost_product product
    return display_cost(Settings.default_cost) if product.product_details.blank?

    display_cost product.product_details.average(:cost)
  end

  def display_cost cost
    cost ||= Settings.default_cost
    t("products.index.currency_unit_front") +
      number_with_delimiter(cost.round, delimiter: Settings.currency_break) +
      t("products.index.currency_unit_back")
  end

  def get_avg_star product
    return Settings.default_star if product.rates.blank?

    product
      .rates.average(:number_of_stars).round Settings.star_round_after_comma
  end

  def display_star_html number_of_star
    number_of_star = number_of_star.round
    star_tags = html_escape("")
    Settings.max_star_rate.times do |n|
      star_tags << if n < number_of_star
                     content_tag :i, "", class: "fa fa-star color-star"
                   else
                     content_tag :i, "", class: "fa fa-star color-black"
                   end
    end

    star_tags
  end

  def gravatar_for user, options = {size: Settings.default_size_avatar}
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "#{Settings.gravatar_url}/#{gravatar_id}?s=#{options}"

    image_tag gravatar_url, alt: user.name, class: "gravatar"
  end

  def display_first_image_product product, size, class_html = ""
    product.product_details.each do |product_detail|
      if product_detail.image.attached?
        return image_tag product_detail.display_image, size: size,
                         class: class_html
      end
    end
    image_tag "empty_image.png", size: size, class: class_html
  end

  def display_image product_detail, size, class_html = ""
    if product_detail.image.attached?
      image_tag product_detail.display_image, size: size,
      class: class_html
    else
      image_tag "empty_image.png", size: size,
      class: class_html
    end
  end

  def custom_bootstrap_flash
    flash_messages = []
    flash.each do |type, message|
      type = "success" if type == "notice"
      type = "error"   if type == "alert"
      text = content_tag(:script, "toastr.#{type}('#{message}');")
      flash_messages << text if message
    end
    safe_join(flash_messages, "\n")
  end
end
