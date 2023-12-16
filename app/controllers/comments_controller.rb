class CommentsController < ApplicationController
    # Set the associated post before certain actions
    before_action :set_post
  
    # Display a form for creating a new comment
    def new
      @comment = Comment.new
    end
  
    # Create a new comment for the associated post
    def create
      # Build a new comment associated with the current user and the specified post
      @comment = current_user.comments.build(comment_params.merge(post: @post))
  
      # Attempt to save the comment
      if @comment.save
        # Redirect to the post's show page if successfully created
        redirect_to user_post_path(@post.author, @post)
      else
        # Render the new comment form if there are validation errors
        render :new
      end
    end
  
    private
  
    # Set the associated post based on the provided post_id
    def set_post
      @post = Post.find(params[:post_id])
    end
  
    # Define the permitted parameters for creating a comment
    def comment_params
      params.require(:comment).permit(:text)
    end
  end
  