class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :product
  has_one :rate, dependent: :destroy
  validates :content, presence: true,
                      length: {maximum: Settings.content_comment_max_len}
  scope :order_created_at, ->{order(created_at: :desc)}
end
