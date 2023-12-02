require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'is considered valid with a title, comments count, and likes count within acceptable ranges' do
    my_user = User.create(name: 'yaser', post_counter: 0)
    post = my_user.posts.new(title: 'Some Post', comments_counter: 0, likes_counter: 0)
    expect(post).to be_valid
  end

  it 'is considered invalid without a title' do
    my_user = User.create(name: 'yaser', post_counter: 0)
    post = my_user.posts.new(title: nil)
    post.valid?
    expect(post.errors[:title]).to include("can't be blank")
  end

  it 'is not valid with a title exceeding 250 characters' do
    my_user = User.create(name: 'yaser', post_counter: 0)
    post = my_user.posts.new(title: 'A' * 251)
    post.valid?
    expect(post.errors[:title]).to include('is too long (maximum is 250 characters)')
  end

  it 'is not valid with a negative comments_counter' do
    my_user = User.create(name: 'yaser', post_counter: 0)
    post = my_user.posts.new(title: 'My Post', comments_counter: -1, likes_counter: 0)
    post.valid?
    expect(post.errors[:comments_counter]).to include('must be greater than or equal to 0')
  end

  it 'is not valid with a negative likes_counter' do
    my_user = User.create(name: 'yaser', post_counter: 0)
    post = my_user.posts.new(title: 'My Post', comments_counter: 0, likes_counter: -1)
    post.valid?
    expect(post.errors[:likes_counter]).to include('must be greater than or equal to 0')
  end

  it 'updates the posts counter for a my_user' do
    my_user = User.create(name: 'yaser', post_counter: 0)
    post = my_user.posts.create(title: 'My Post', comments_counter: 0, likes_counter: 0)

    post.increment_user_post_counter

    my_user.reload
    expect(my_user.post_counter).to eq(2)
  end
end
