require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'it can update post comments_counter after save' do
    user = FactoryBot.create(:user)
    post = FactoryBot.create(:post, author: user)

    expect {
      FactoryBot.create(:comment, user: user, post: post)
      post.reload
    }.to change { post.comments_counter }.from(0).to(1)
  end
end
