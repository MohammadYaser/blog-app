# spec/features/user_show_spec.rb

require 'rails_helper'

RSpec.describe 'User Show Page', type: :feature do
  before(:each) do
    @user = create(:user)
    @posts = create_list(:post, 2, author: @user)
    visit user_path(@user)
    @comment1 = Comment.create(user: @user1, post: @first_post, text: 'Hi Tom Wonderful!')
  end

  it "displays the user's profile picture" do
    expect(page).to have_css("img[src*='#{@user.photo}']")
  end

  it 'displays the user\'s username' do
    expect(page).to have_content(@user.name)
  end

  it 'displays the number of posts the user has written' do
    expect(page).to have_content(@user.posts_counter)
  end

  it 'displays a post\'s title' do
    expect(page).to have_content(@posts.first.title)
  end

  it 'displays some of the post\'s body' do
    expect(page).to have_content(@posts.first.text)
  end

  it 'displays how many comments a post has' do
    create_list(:comment, 3, user: @user, post: @posts.first)
    visit user_path(@user)
    expect(page).to have_content("Comments: #{@posts.first.comments.count}")
  end

  it 'displays how many likes a post has' do
    create_list(:like, 4, user: @user, post: @posts.first)
    visit user_path(@user)
    expect(page).to have_content("Likes: #{@posts.first.likes.count}")
  end
end
