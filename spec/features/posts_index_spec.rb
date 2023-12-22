# spec/features/user_show_spec.rb

require 'rails_helper'

RSpec.describe 'User Show Page', type: :feature do
  let!(:user) { User.create(name: 'Yaser', photo: 'https://avatars.githubusercontent.com/u/130588108?v=4') }
  let!(:post) { Post.create(author_id: user.id, title: 'Test Post', text: 'Hello world!') }
  let!(:comment1) { Comment.create(user: user, post: post, text: 'Hello reviewer!') }
  let!(:comment2) { Comment.create(user: user, post: post, text: 'Hope everything is just fine for you!') }

  before { visit user_posts_path(user) }

  it "displays the user's profile picture" do
    expect(page).to have_css("img[src*='#{user.photo}']")
  end

  it 'displays the user\'s username' do
    expect(page).to have_content(user.name)
  end

  it 'displays the number of posts the user has written' do
    expect(page).to have_content(user.posts_counter)
  end

  it 'displays a post\'s title' do
    expect(page).to have_content(post.title)
  end

  it 'displays some of the post\'s body' do
    expect(page).to have_content(post.text)
  end

  scenario 'Displays the first comments on a post and total comments' do
    expect(page).to have_content(comment1.text)
    expect(page).to have_content(comment2.text)
    expect(page).to have_content("Comments: #{post.comments_counter}")
  end
  scenario 'Redirects to post show page when clicked' do
    click_link post.title
    sleep(1)
    expect(current_path).to eq(user_post_path(user, post))
  end
  scenario 'Displays pagination section when there are more than 5 posts' do
    6.times { Post.create(author: user, title: 'My post', text: 'Ruby on Rails.') }

    visit user_posts_path(user)
    expect(page).to have_css('.pagination')
  end

  scenario 'Displays the correct number of comments for the post' do
    expect(page).to have_content("Comments: #{post.comments_counter}")
  end

  scenario 'Displays the correct number of likes for the post' do
    expect(page).to have_content("Likes: #{post.likes_counter}")
  end
end
