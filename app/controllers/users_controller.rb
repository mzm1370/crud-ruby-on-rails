class UsersController < ApplicationController
    before_action :authenticate_request
  
    def index
      if current_user.admin?
        @users = User.all
      else
        @users = [current_user]  
      end
      authorize User
    end
  
    def show
      @user = User.find(params[:id])
      authorize @user
    end
  
    def new
      @user = User.new
    end
  
    def edit
      @user = User.find(params[:id])
    end
  
    def create
      @user = User.new(user_params)
      if @user.save
        redirect_to new_user_path, notice:'User was successfully created'
      else
        redirect_to new_user_path, notice:'The email or username entered is duplicate'
      end
    end
  
    def update
      @user = User.find(params[:id])
      if @user.update(user_params)
        redirect_to users_path, notice: 'User was successfully updated'
      else
        render :edit
      end
    end
  
    def destroy
      @user = User.find(params[:id])
      @user.destroy
      redirect_to users_path, notice: "User was successfully deleted."
    end
  
    private
  
    def user_params
      params.require(:user).permit(:email, :username, :password, :role)
    end

    def require_login
        unless session[:jwt_token]
            redirect_to login_url, notice: "You must be logged in to access this page"
        end
    end

    def current_user
        return nil unless session[:jwt_token]

        begin
            decoded_token = JWT.decode(session[:jwt_token], Rails.application.secrets.secret_key_base)
            @current_user ||= User.find(decoded_token[0]['user_id'])
        rescue JWT::DecodeError
            session[:jwt_token] = nil
            redirect_to login_url, notice: 'Session expired. Please log in again.'
        end
    end
  end
