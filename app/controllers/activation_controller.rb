class ActivationController < ApplicationController
  def create
    user = User.find(params[:id])
    user.active!
    flash[:notice] = "You've successfully activated your account!"
    redirect_to '/confirmation'
  end

  def show
  end
end
