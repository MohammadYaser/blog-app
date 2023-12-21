# spec/factories/users.rb

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    photo { 'https://icons.iconarchive.com/icons/iconsmind/outline/256/User-icon.png' }
  end
end
