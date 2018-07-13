class Api::V1::ApplicationController < ActionController::API
  before_action :require_valid_api_key

  def require_valid_api_key
    unless User.find_by(auth_token: request.headers['HTTP_X_API_KEY'])
      render status: 401
    end
  end
end
