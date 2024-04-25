class SessionsController < ApplicationController
  skip_before_action :require_login, except: [:register_path]
  def new
  end
  def create
    user = User.find_by(email: params[:email])
    logger.debug("error:#{user&.authenticate(params[:password])}")
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "Logged in successfully!"
    else
      # flash.now[:alert] = "Invalid email or password"
      redirect_to login_path, notice: "Invalid email or password"
      # render :new
    end
  end
  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: "Logged out successfully!"
  end
end
