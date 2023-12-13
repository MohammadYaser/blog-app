# rails_helper.rb

# Including necessary configurations for RSpec
require 'rails_helper'

# RSpec tests for the PostsController
RSpec.describe 'Posts', type: :request do
  # Create a user and post using FactoryBot
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post, author: user) }

  # Testing the index action
  describe 'GET #index' do
    # Make a GET request to the user's posts index path before each example
    before { get user_posts_path(user) }

    # Example: Check if the response has a successful HTTP status
    it 'returns a success response' do
      expect(response).to have_http_status(:success)
    end

    # Example: Check if the response renders the index template
    it 'renders the index template' do
      expect(response).to render_template(:index)
    end

    # Example: Check if the response body includes specific text
    it 'includes correct placeholder text in the response body' do
      expect(response.body).to include('User 1 all posts')
    end
  end

  # Testing the show action
  describe 'GET #show' do
    # Make a GET request to the specific user's post path before each example
    before { get user_post_path(user, post) }

    # Example: Check if the response has a successful HTTP status
    it 'returns a success response' do
      expect(response).to have_http_status(:success)
    end

    # Example: Check if the response renders the show template
    it 'renders the show template' do
      expect(response).to render_template(:show)
    end

    # Example: Check if the response body includes specific text
    it 'includes correct placeholder text in the response body' do
      expect(response.body).to include('post 1 by user 1')
    end
  end
end
