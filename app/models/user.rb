# The User class represents users in the application.
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Associations:
  # - A user has many posts where the user is the author.
  # - A user has many likes.
  # - A user has many comments.
  has_many :posts, foreign_key: :author_id
  has_many :likes
  has_many :comments

  # Validations:
  # - Presence validation for the name attribute.
  # - Numericality validation for posts_counter attribute (must be an integer, greater than or equal to 0).
  validates :name, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # Custom Method: three_recent_posts
  # - Returns the three most recent posts authored by the user.
  def three_recent_posts
    posts.order(created_at: :desc).limit(3)
  end
end
