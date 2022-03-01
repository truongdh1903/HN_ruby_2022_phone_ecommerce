class ProductDetail < ApplicationRecord
  belongs_to :product
  belongs_to :product_color
  belongs_to :product_size
  has_many :carts, dependent: :destroy
  has_many :order_details, dependent: :destroy
  has_one_attached :image

  validates :cost, presence: true, numericality: {only_integer: true}
  validates :quantity, presence: true, numericality: {only_integer: true}
  validates :image, content_type:
                    {in: Settings.accept_file_model,
                     message:
                       I18n.t("admin.product_details.valid_image.format")},
                     size: {less_than: Settings.maximum_size_file.megabytes,
                            message:
                              I18n.t("admin.product_details.valid_image.size")}

  def display_image size = Settings.size_image_big
    image.variant resize_to_limit: [size, size]
  end
end
