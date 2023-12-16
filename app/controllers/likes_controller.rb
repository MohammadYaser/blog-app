class LikesController < ApplicationController
    # Set the associated post before certain actions
    before_action :find_post
  
    # Create a new like for the associated post
    def create
      # Build a new like associated with the current user and the specified post
      @like = @post.likes.new(user: current_user)
  
      # Attempt to save the like
      if @like.save
        # Redirect to the post's show page with a notice if successfully created
        redirect_to user_post_path(@post.author, @post), notice: 'You liked the post!'
      else
        # Redirect to the post's show page with an alert if unable to save the like
        redirect_to user_post_path(@post.author, @post), alert: 'Unable to like the post.'
      end
    end
  
    private
  
    # Set the associated post based on the provided post_id
    def find_post
      @post = Post.find(params[:post_id])
    end
  end
  