# rails_helper.rb

# Including necessary configurations for RSpec
require 'rails_helper'

# RSpec tests for the UsersController
RSpec.describe 'Users', type: :request do
  # Testing the index action
  describe 'GET #index' do
    it 'returns a successful response' do
      # Make a GET request to the users index path
      get users_path

      # Expect the HTTP response status to be 200 (OK)
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      # Make a GET request to the users index path
      get users_path

      # Expect the response to render the index template
      expect(response).to render_template(:index)
    end

    it 'includes correct placeholder text in the response body' do
      # Make a GET request to the users index path
      get users_path

      # Expect the response body to include the specified text
      expect(response.body).to include('List of all users:')
    end
  end

  # Testing the show action
  describe 'GET #show' do
    # Create a user using the FactoryBot's create method
    let(:user) { create(:user) }

    it 'returns a successful response' do
      # Make a GET request to the user's show path
      get user_path(user)

      # Expect the HTTP response status to be 200 (OK)
      expect(response).to have_http_status(200)
    end

    it 'renders the show template' do
      # Make a GET request to the user's show path
      get user_path(user)

      # Expect the response to render the show template
      expect(response).to render_template(:show)
    end

    it 'includes correct placeholder text in the response body' do
      # Make a GET request to the user's show path
      get user_path(user)

      # Expect the response body to include the specified text
      expect(response.body).to include('User one')
    end
  end
end
