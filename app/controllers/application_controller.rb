class ApplicationController < ActionController::Base
  include Pagy::Backend
  include SessionsHelper
  include ProductHelper

  before_action :set_locale
  before_action :permit_params, if: :devise_controller?

  private
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def permit_params
    devise_parameter_sanitizer.permit :sign_up, keys: User::PROPERTIES
    devise_parameter_sanitizer.permit :account_update, keys: User::PROPERTIES
  end
end
