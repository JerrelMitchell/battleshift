class UsersController < ApplicationController
  def new
  end

  def create
    redirect_to '/dashboard'
  end
end