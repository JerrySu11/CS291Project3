class UsersController < ApplicationController
    def index
      @users = User.all
    end
  
    def show
      @user = User.find(params[:id]) rescue not_found
    end
  
    def new
      @user = User.new
    end
  
    def create
      @user = User.new(user_params)
  
      if @user.save
        redirect_to @user
      else
        render :new, status: :unprocessable_entity
      end
    end
    def edit
      @user = User.find(params[:id]) rescue not_found
    end
  
    def update
      @user = User.find(params[:id]) rescue not_found
  
      if @user.update(user_params)
        redirect_to @user
      else
        render :edit, status: :unprocessable_entity
      end
    end
  
    def destroy
      @user = User.find(params[:id]) rescue not_found
      @user.posts.destroy
      @user.destroy
  
      redirect_to users_path, status: :see_other
    end
  
    private
      def user_params
        params.require(:user).permit(:name, :bio)
      end

end
