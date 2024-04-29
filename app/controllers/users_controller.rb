class UsersController < ApplicationController
    # before_action :set_user, only: [:show, :edit, :update, :destroy]

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
            redirect_to new_user_path,notice:'User was successfully created'
        else
            redirect_to new_user_path,notice:'The email or username entered is duplicate'
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
            logger.debug "User meysam: #{params.require(:user)}"
            params.require(:user).permit(:email, :username, :password, :role)
        end

        def set_user
            @user = User.find(params[:id])
        end

        
end
