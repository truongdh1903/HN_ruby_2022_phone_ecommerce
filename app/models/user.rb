class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token, :reset_token
  has_many :carts, dependent: :destroy
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
  before_create :create_activation_digest
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

  enum role: {admin: 0, supplier: 1, user: 2}

  has_secure_password

  def remember
    self.remember_token = User.new_token
    update_column :remember_digest, User.digest(remember_token)
  end

  def authenticated? attribute, token
    digest = send "#{attribute}_digest"
    return false unless digest

    BCrypt::Password.new(digest).is_password? token
  end

  def forget
    update_column :remember_digest, nil
  end

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

  def activate
    update_columns activated: true, activated_at: Time.zone.now
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < Settings.expire_hour.hours.ago
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_columns reset_digest: User.digest(reset_token),
      reset_sent_at: Time.zone.now
  end

  private
  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest activation_token
  end

  def downcase_email
    email.downcase!
  end
end
