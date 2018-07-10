class ActivationController < ApplicationController
  def create
    user = User.find(params[:id])
    user.active!
    redirect_to '/confirmation'
  end

  def show
  end
end
