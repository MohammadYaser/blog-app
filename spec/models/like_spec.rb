require 'rails_helper'

RSpec.describe Like, type: :model do
  it 'it can update post likes_counter after save' do
    user = FactoryBot.create(:user)
    post = FactoryBot.create(:post, author: user)

    expect {
      FactoryBot.create(:like, user: user, post: post)
      post.reload
    }.to change { post.likes_counter }.from(0).to(1)
  end
end
