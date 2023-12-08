# spec/factories/comments.rb
FactoryBot.define do
    factory :comment do
      text { 'Sample Comment' }
      association :user
      association :post
    end
  end