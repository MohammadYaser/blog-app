require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is considered valid with a username and a non-negative post count' do
    my_user = User.new(name: 'Ali', post_counter: 0)
    expect(my_user).to be_valid
  end

  it 'is considered invalid without a username' do
    my_user = User.new(name: nil)
    my_user.valid?
    expect(my_user.errors[:name]).to include("can't be blank")
  end

  it 'is considered invalid with a negative post count' do
    my_user = User.new(name: 'Tom', post_counter: -1)
    my_user.valid?
    expect(my_user.errors[:post_counter]).to include('must be greater than or equal to 0')
  end

  it 'returns the 3 most recent posts' do
    my_user = User.create(name: 'Tom', post_counter: 0)
    4.times { my_user.posts.create(title: 'My Post', comments_counter: 0, likes_counter: 0) }

    recent_posts = my_user.recent_posts

    expect(recent_posts.count).to eq(3)
    expect(recent_posts.first).to eq(my_user.posts.last)
  end

  # New test for the recent_posts method
  # New test for the recent_posts method
  it 'returns all posts if the user has fewer than 3 posts' do
    my_user = User.create(name: 'John', post_counter: 0)
    2.times { my_user.posts.create(title: 'Another Post', comments_counter: 0, likes_counter: 0) }

    recent_posts = my_user.recent_posts

    expect(recent_posts.count).to eq(2)
    expect(recent_posts).to match_array(my_user.posts)
  end

end
