class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "user_created"
      redirect_to root_url
    else
      render :new
    end
  end

  def edit; end

  def update; end

  def destroy; end

  private
  def user_params
    params.require(:user).permit :name, :email, :phone, :address, :role,
                                 :password, :password_confirmation
  end
end
