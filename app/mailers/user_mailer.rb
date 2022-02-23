class UserMailer < ApplicationMailer
  def account_activation user, activation_token
    @user = user
    @user.activation_token = activation_token
    mail to: user.email, subject: t("account_activation")
  end

  def password_reset user, activation_token
    @user = user
    @user.activation_token = activation_token
    mail to: user.email, subject: t("password_reset.title")
  end
end
