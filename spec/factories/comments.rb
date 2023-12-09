FactoryBot.define do
  factory :comment do
    text { 'hi how are you!' }
    association :user, factory: :user
    association :post, factory: :post
  end
end
