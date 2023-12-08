# The Post class represents posts made by users in the application.
class Post < ApplicationRecord
  # Associations:
  # - A post belongs to an author, which is an instance of the User class.
  # - A post has many likes.
  # - A post has many comments.
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :likes
  has_many :comments

  # Validations:
  # - Presence validation for the title attribute.
  # - Length validation for the title attribute (maximum: 250 characters).
  # - Numericality validation for comments_counter and likes_counter attributes (must be integers, greater than or equal to 0).
  validates :title, presence: true
  validates :title, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # Custom Method: five_most_recent_comments
  # - Returns the five most recent comments associated with the post.
  def five_most_recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  # Callback:
  # - After saving a post, the `update_posts_counter` method is called to update the author's posts counter.
  after_save :update_posts_counter

  private

  # Private Method: update_posts_counter
  # - This method is called in the after_save callback to update the posts_counter of the associated author.
  # - It fetches the current count of posts associated with the author and updates the posts_counter attribute of the author.
  def update_posts_counter
    author.update(posts_counter: author.posts.count)
  end
end
