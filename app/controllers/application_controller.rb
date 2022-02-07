class ApplicationController < ActionController::Base
  include Pagy::Backend
  include SessionsHelper
  include ProductHelper
  before_action :set_locale

  def logged_in_user
    return if logged_in?

    flash[:danger] = t "please_log_in"
    redirect_to login_url
  end

  private
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end
end
