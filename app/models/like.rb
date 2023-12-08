# The Like class represents user likes on posts in the application.
class Like < ApplicationRecord
  # Associations:
  # - A like belongs to a user.
  # - A like belongs to a post.
  belongs_to :user
  belongs_to :post

  # Callback:
  # - After saving a like, the `update_likes_counter` method is called to update the associated post's likes counter.
  after_save :update_likes_counter

  private

  # Private Method: update_likes_counter
  # - This method is called in the after_save callback to update the likes_counter of the associated post.
  # - It fetches the current count of likes associated
  # with the post and updates the likes_counter attribute of the post.
  def update_likes_counter
    post.update(likes_counter: post.likes.count)
  end
end
