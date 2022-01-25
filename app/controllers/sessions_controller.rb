class SessionsController < ApplicationController
  before_action :load_user_by_email, only: :create

  def new; end

  def create
    if @user&.authenticate params[:session][:password]
      if @user.activated?
        log_in_redirect @user
      else
        flash[:warning] = t "account_not_activated"
        redirect_to root_url
      end
    else
      flash.now[:danger] = t "invalid_info"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private
  def log_in_redirect user
    log_in user
    params[:session][:remember_me] == "1" ? remember(user) : forget(user)
    redirect_to_shop
  end

  def load_user_by_email
    @user = User.find_by email: params[:session][:email].downcase
    return if @user

    flash.now[:danger] = t "invalid_email"
    render :new
  end
end
