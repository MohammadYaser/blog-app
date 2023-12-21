class PostsController < ApplicationController
  # Display a list of posts for a specific user
  def index
    # Retrieve posts for the specified user
    @posts = Post.where(author_id: params[:user_id])
    # Retrieve the user associated with the posts
    @user = User.find(params[:user_id])
  end

  # Display details of a specific post
  def show
    # Retrieve the post based on the provided ID
    @post = Post.find(params[:id])
    # Retrieve the user associated with the post
    @user = User.find(@post.author_id)
  end

  # Display a form for creating a new post
  def new
    # Retrieve the user for whom the new post is being created
    @user = User.find(params[:user_id])
    # Build a new post associated with the user
    @post = @user.posts.build
  end

  # Create a new post
  def create
    # Retrieve the user for whom the new post is being created
    @user = User.find(params[:user_id])
    # Build a new post associated with the user and populate it with the submitted parameters
    @post = @user.posts.build(post_params)

    # Attempt to save the post
    if @post.save
      # Redirect to the post's show page if successfully created
      redirect_to user_post_path(@user, @post), notice: 'Post was successfully created.'
    else
      # Render the new post form if there are validation errors
      render :new
    end
  end

  private

  # Define the permitted parameters for creating a post
  def post_params
    params.require(:post).permit(:title, :text)
  end

  # Callback to find and set the post for certain actions
  def find_post
    @post = Post.find(params[:id])
  end

  # Callback to initialize a new like for certain actions
  def initialize_like
    @like = Like.new
  end
end
