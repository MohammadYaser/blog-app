class UsersController < ApplicationController
  def index
    @users = User.includes(:posts).all
  end

  def show
    user_id = params[:id]
    @user = User.find(user_id)
    @posts = @user.three_recent_posts
  end
end
