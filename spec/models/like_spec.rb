require 'rails_helper'

RSpec.describe Like, type: :model do
  it 'it can update post likes_counter after save' do
    user = FactoryBot.create(:user)
    post = FactoryBot.create(:post, author: user)

    expect do
      FactoryBot.create(:like, user: user, post: post)
      post.reload
    end.to change { post.likes_counter }.from(0).to(1)
  end
end
