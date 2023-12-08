# spec/models/comment_spec.rb
require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post) }

  describe 'validations' do
    it { should validate_presence_of(:text) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end

  describe 'methods' do
    describe '#increment_post_comments_counter' do
      it 'increments the comments_counter of the associated post' do
        comment = create(:comment, user: user, post: post)

        expect {
          comment.increment_post_comments_counter
          post.reload
        }.to change { post.comments_counter }.by(1)
      end
    end
  end
end
