class ActivationController < ApplicationController
  def create
    user = User.find_by(activation_token: params[:activation_token])
    user.active!
    redirect_to '/confirmation'
  end

  def show
  end
end
