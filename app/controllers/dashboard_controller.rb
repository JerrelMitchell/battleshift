class DashboardController < ApplicationController
  def show
    if current_user
      render
    else
      redirect_to '/login'
    end
  end
end
