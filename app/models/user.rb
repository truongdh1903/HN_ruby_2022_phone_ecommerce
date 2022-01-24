class User < ApplicationRecord
  has_many :orders, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :rates, dependent: :destroy
  has_many :sent_messages, class_name: Message.name,
                           foreign_key: "user_sender_id",
                           dependent: :destroy
  has_many :received_messages, class_name: Message.name,
                               foreign_key: "user_receiver_id",
                               dependent: :destroy
  before_save :downcase_email

  validates :address, presence: true
  validates :name, presence: true
  validates :phone, presence: true, numericality: true,
                    length: {in: Settings.phone_len_range}
  validates :email, presence: true, length: {maximum: Settings.email_max_len},
    format: {with: Settings.email_regex},
    uniqueness: true
  validates :password, presence: true,
    length: {minimum: Settings.passwd_min_len}, allow_nil: true
  has_secure_password

  class << self
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  private
  def downcase_email
    email.downcase!
  end
end
