class UsersController < ApplicationController
		before_action :authenticate_user!
  def show
  	@user = User.find(params[:id])
    @book = Book.new
    @books = @user.books

  end
  def edit
  	@user = User.find(params[:id])
    if current_user.id != @user.id
      redirect_to user_path(current_user)
    end
  end

  def update
  	@user = User.find(params[:id])
    if@user.update(user_params)
      flash[:notice] = "your profile was updated successfully"
  	   redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def index
    @users =User.all
    @book = Book.new
  end

  def following
      @user  = User.find(params[:id])
      @users = @user.followings
      render 'show_follow'
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follower'
  end

  private
  def user_params
  	params.require(:user).permit(:name, :profile_image, :introduction)
  end
end

