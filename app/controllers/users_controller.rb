class UsersController < ApplicationController
  before_action :find_current_user, only: %i(show edit update)

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t "check_email"
      redirect_to root_url
    else
      render :new
    end
  end

  def show
    render :edit
  end

  def edit; end

  def update
    if @user.update user_params
      flash.now[:success] = t "profile_updated"
    else
      flash.now[:danger] = t "update failed"
    end
    render :edit
  end

  def destroy; end

  private
  def user_params
    params.require(:user).permit :name, :email, :phone, :address, :role,
                                 :password, :password_confirmation
  end

  def find_current_user
    @user = current_user
  end
end
