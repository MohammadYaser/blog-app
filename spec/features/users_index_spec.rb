# spec/features/user_index_spec.rb

require 'rails_helper'

RSpec.feature 'User Index Page', type: :feature do
  let!(:users) { create_list(:user, 3) }

  scenario 'User can see the usernames of all other users' do
    visit users_path

    users.each do |user|
      expect(page).to have_link(user.name, href: user_path(user))
    end
  end

  scenario 'User can see the profile picture for each user' do
    visit users_path

    users.each do |user|
      # Check if the user's photo is present in the page
      expect(page).to have_css("img[src*='#{user.photo}'][alt='User Photo'][class='user-photo']")
    end
  end
  
  scenario 'User can see the number of posts each user has written' do
    # Create posts for each user
    users.each { |user| create_list(:post, 2, author: user) }

    visit users_path

    users.each do |user|
      # Check if the user's post count is present in the page
      expect(page).to have_content("Number of Posts: #{user.posts.count}")
    end
  end

end