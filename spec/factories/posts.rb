# spec/factories/posts.rb

FactoryBot.define do
  factory :post do
    title { "some title" }
    text { "some text to the post" }

    # Regular attributes for the post

    trait :with_author do
      association :author, factory: :user
    end
  end
end
