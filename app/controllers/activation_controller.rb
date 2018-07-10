class ActivationController < ApplicationController
  def create
    ActivationNotifierMailer.inform(current_user, params[:email]).deliver_now
    flash[:notice] = "You've successfully activated your account!"
    redirect_to '/dashboard'
  end
end
