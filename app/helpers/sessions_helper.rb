module SessionsHelper
  def redirect_to_shop
    redirect_to root_url
  end

  def check_role_admin
    return if user_signed_in? && current_user.admin?

    flash[:danger] = t "not_admin"
    redirect_to_shop
  end
end
