class SendEmailActivationJob < ApplicationJob
  queue_as :default

  def perform user_id, activation_token
    user = User.find_by id: user_id
    UserMailer.account_activation(user, activation_token).deliver_now
  end
end
