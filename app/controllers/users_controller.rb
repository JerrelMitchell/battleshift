class UsersController < ApplicationController
  def new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      ActivationNotifierMailer.inform(user).deliver_now
      flash[:notice] = "You've successfully activated your account!"
      redirect_to '/dashboard'
    else
      flash[:error] = "Please make sure all fields are complete"
      render :new
    end
  end

private
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
