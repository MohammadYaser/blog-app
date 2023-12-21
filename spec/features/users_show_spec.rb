# spec/features/user_show_spec.rb

require 'rails_helper'

RSpec.describe 'User Show Page', type: :feature do
  before(:each) do
    @user1 = User.create(name: 'John', photo: 'https://icons.iconarchive.com/icons/iconsmind/outline/256/User-icon.png',
                         bio: 'Lorem ipsum.',
                         posts_counter: 0)
    @post = create(:post, author: @user1, title: 'some title')
    visit user_path(@user1)
  end

  it "displays the user's profile picture" do
    expect(page).to have_css("img[src*='#{@user1.photo}']")
  end

  it 'displays the username' do
    expect(page).to have_content(@user1.name)
  end

  it 'displays the number of posts' do
    expect(page).to have_content(@user1.posts_counter)
  end

  it "displays the user's bio" do
    expect(page).to have_content(@user1.bio)
  end

  it 'displays the post title' do
    expect(page).to have_content(@post.title)
  end

  it 'displays a button to view all posts' do
    expect(page).to have_link('See all posts')
  end

  it "redirects to a user's post index page when 'See all posts' button is clicked" do
    click_link 'See all posts'
    expect(page).to have_current_path(user_posts_path(@user1))
  end

  it "redirects to a user's post show page when clicking a post" do
    click_link 'some title'
    expect(page).to have_current_path(user_post_path(@user1, @post))
  end
end
