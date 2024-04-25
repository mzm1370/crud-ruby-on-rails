class UsersController < ApplicationController
    # before_action :set_user, only: [:show, :edit, :update, :destroy]

    def index
        @users = User.all
    end

    def show
    end

    def new
        @user = User.new
    end

    def edit
    end

    def create
        @user = User.new(user_params)
        
        # Alternatively, you can use logger
        if @user.save
            redirect_to register_path,notice:'User was successfully created'
        else
            redirect_to register_path,notice:'The email or username entered is duplicate'
        end
    end



    def update
        if @user.update(user_params)
            redirect_to @user, notice: 'User was successfully updated'
        else
            render :edit
        end
    end

    def destory
        @user.destory
        redirect_to users_url, notice: 'User was successfully destroyed'
    end

    
    private
        def user_params
            logger.debug "User meysam: #{params.require(:user)}"
            params.require(:user).permit(:email, :username, :password)
        end

        def set_user
            @user = User.find(params[:id])
        end

        
end
