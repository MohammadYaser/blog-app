# spec/models/like_spec.rb
require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post) }

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end
end
