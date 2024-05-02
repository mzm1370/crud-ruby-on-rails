class WelcomeController < ApplicationController
  before_action :authenticate_request
  before_action :require_login
  
  def index
    
  end
  
  private
  
  def require_login
    unless current_user
      redirect_to login_url, notice: "You must be logged in to access this page"
    end
  end
end
