class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      ActivationNotifierMailer.inform(@user).deliver_now
      redirect_to '/dashboard'
    else
      flash[:error] = "Please make sure all fields are complete"
      render :new
    end
  end

private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
