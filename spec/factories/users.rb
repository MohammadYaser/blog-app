FactoryBot.define do
  factory :user do
    name { 'Mohammad Yaser Safi' }
    photo { 'test.png' }
    bio { 'this is some bio' }
    posts_counter { 0 }
  end
end
