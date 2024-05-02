class SessionsController < ApplicationController
  skip_before_action :authenticate_request, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      token = JWT.encode({ user_id: user.id }, Rails.application.secrets.secret_key_base)
      session[:jwt_token] = token
      redirect_to home_url, notice: 'Logged in successfully.'
    else
      redirect_to login_path, notice: "Invalid email or password."
    end
  end

  def destroy
    session[:jwt_token] = nil
    redirect_to login_path, notice: "Logged out successfully!"
  end
end
