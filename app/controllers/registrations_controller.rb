class RegistrationsController < ApplicationController
  skip_before_action :authenticate_request
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.role = 'user'
    puts @user.inspect 
    if @user.save
      redirect_to register_path,notice:'User was successfully created'
    else
      redirect_to register_path,notice:'The email or username entered is duplicate'
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :username, :password)
  end
end
