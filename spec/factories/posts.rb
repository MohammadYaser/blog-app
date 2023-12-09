FactoryBot.define do
  factory :post do
    title { 'some title' }
    text { 'some text to the post' }
    comments_counter { 0 }
    likes_counter { 0 }
    association :author, factory: :user
  end
end
