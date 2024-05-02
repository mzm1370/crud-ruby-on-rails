class ApplicationController < ActionController::Base
  include Pundit
  before_action :authenticate_request, unless: :register_action?
  before_action :require_login, except: [:register]

  private

  def authenticate_request
    if session[:jwt_token]
      begin
        decoded_token = JWT.decode(session[:jwt_token], Rails.application.secrets.secret_key_base)
        @current_user = User.find(decoded_token[0]['user_id'])
      rescue JWT::DecodeError
        session[:jwt_token] = nil
        redirect_to login_url, notice: 'Session expired. Please log in again.'
      end
    else
      redirect_to login_url, notice: 'You must log in to access this page.'
    end
  end

  def current_user
    @current_user
  end
  helper_method :current_user

  def require_login
    unless current_user || allowed_paths.include?(request.path)
      redirect_to login_url, notice: 'You must log in to access this page.'
    end
  end

  def allowed_paths
    ['/login', '/register']
  end

  def register_action?
    params[:controller] == 'users' && params[:action] == 'create'
  end
end