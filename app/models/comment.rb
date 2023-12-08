# The Comment class represents comments made by users on posts in the application.
class Comment < ApplicationRecord
  # Associations:
  # - A comment belongs to a post.
  # - A comment belongs to a user.
  belongs_to :post
  belongs_to :user

  # Callback:
  # - After saving a comment, the `update_comments_counter`
  # method is called to update the associated post's comments counter.
  after_save :update_comments_counter

  private

  # Private Method: update_comments_counter
  # - This method is called in the after_save callback to update the comments_counter of the associated post.
  # - It fetches the current count of comments associated
  # with the post and updates the comments_counter attribute of the post.
  def update_comments_counter
    post.update(comments_counter: post.comments.count)
  end
end
