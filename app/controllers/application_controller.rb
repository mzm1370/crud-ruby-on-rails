class ApplicationController < ActionController::Base
    before_action :require_login, except: [:register]

    private

    def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end
    helper_method :current_user

    def require_login
        unless current_user || request.path == "/login" || request.path == "/register"
            redirect_to login_url, notice: "You must be logged in to access this page"
        end
    end

    
end