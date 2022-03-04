class Order < ApplicationRecord
  belongs_to :user, optional: true
  has_many :order_details, dependent: :destroy
  validates :delivery_address, presence: true
  validates :delivery_phone, presence: true,
                             length: {in: Settings.phone_len_range}
  before_create :set_status

  enum status: {pending: 0, accept: 1, reject: 3, waiting: 5,
                shipped: 7, cancel: 9}, _suffix: true

  scope :group_status, ->{group(Arel.sql("status")).count}
  scope :group_shiped_date, (lambda do
    where("year(shiped_date) = #{Settings.year_chart}")
    .group(Arel.sql("month(shiped_date)"))
    .count
  end)

  def set_status
    self.status = Order.statuses[:pending]
  end

  scope :order_created_at, ->{order(created_at: :desc)}
end
