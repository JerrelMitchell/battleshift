 class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :determine_content

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def determine_content
    @determine_content = UserPresenter.find_content(current_user, 'layouts/user_nav', 'layouts/visitor_nav')
  end
end
