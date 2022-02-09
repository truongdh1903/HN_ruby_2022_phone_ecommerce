class Order < ApplicationRecord
  belongs_to :user, optional: true
  has_many :order_details, dependent: :destroy
  validates :delivery_address, presence: true
  validates :delivery_phone, presence: true,
                             length: {in: Settings.phone_len_range}
  before_create do
    self.status = "pending"
  end

  enum status: {pending: 0}
end
