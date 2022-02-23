class SendEmailResetPasswordJob < ApplicationJob
  queue_as :default

  def perform user_id
    user = User.find_by id: user_id
    UserMailer.password_reset(user).deliver_now
  end
end
