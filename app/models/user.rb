class User < ApplicationRecord
  PROPERTIES = %i(name email address phone password desc
                  password_confirmation remember_me).freeze
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
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
  before_save :downcase_email

  enum role: {admin: 0, supplier: 1, user: 2}

  private

  def downcase_email
    email.downcase!
  end
end
