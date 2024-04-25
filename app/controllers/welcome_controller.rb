class WelcomeController < ApplicationController
  
  def index
  end
  private
  def require_login
    unless current_user
      redirect_to login_url, notice: "You must be logged in to access this page"
    end
  end
end
