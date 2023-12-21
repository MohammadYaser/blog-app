# Assuming this test is part of a feature spec
require 'rails_helper'

RSpec.describe 'Post Show Page', type: :feature do
  before(:each) do
    # Set up any necessary data or visit the post show page
    @user = create(:user)
    @post = create(:post, author: @user) # Change 'user' to 'author'
    @comment1 = create(:comment, user: @user, post: @post, text: 'First comment')
    @comment2 = create(:comment, user: @user, post: @post, text: 'Second comment')
    visit user_post_path(@user, @post)
    @post1 = create(:post, :with_author, author: @user, likes_counter: 2)
  end

  it "displays the post's title" do
    expect(page).to have_content(@post.title)
  end
  it 'displays the number of comments a post has' do
    expect(page).to have_content("Comments: 💬2")
  end
  it 'displays the number of likes a post has' do
    expect(page).to have_content(@post1.likes_counter)
  end
  
  let!(:user1) { User.create(name: 'Yaser', photo: 'https://avatars.githubusercontent.com/u/130588108?v=4') }
  let!(:post1) { Post.create(author_id: user1.id, title: 'Test post 1', text: 'Ruby on Rails.') }
  let!(:comment1) { Comment.create(user: user1, post: post1, text: 'Hello there!') }
  let!(:comment2) { Comment.create(user: user1, post: post1, text: 'Hi everyone!') }

  scenario 'Displays post title and author' do
    visit user_post_path(user1, post1)
    expect(page).to have_content(post1.title)
    expect(page).to have_content(user1.name)
  end

  scenario 'Displays the post body' do
    visit user_post_path(user1, post1)

    expect(page).to have_content('Ruby on Rails.')
  end

  scenario 'Displays the username of each commentator' do
    visit user_post_path(user1, post1)
    expect(page).to have_content(comment1.user.name)
    expect(page).to have_content(comment2.user.name)
  end

  scenario 'Displays the comment left by each commentor' do
    visit user_post_path(user1, post1)
    expect(page).to have_content(comment1.text)
    expect(page).to have_content(comment2.text)
  end

end
