FactoryBot.define do
    factory :user do
      name { Faker::Name.name }  # You can use the Faker gem for generating random names
  
      # Add any other attributes you have in your User model
      post_counter { 0 }  # Assuming the default value for post_counter is 0
  
      # Define associations
      transient do
        posts_count { 3 }  # Number of posts to create per user by default
      end
  
      after(:create) do |user, evaluator|
        create_list(:post, evaluator.posts_count, author: user)
      end
  
      # Define any other associations (comments, likes) if needed
  
      # Define any other traits or attributes specific to your application
  
      # Example trait for a user with comments
      trait :with_comments do
        transient do
          comments_count { 3 }  # Number of comments to create per user by default
        end
  
        after(:create) do |user, evaluator|
          create_list(:comment, evaluator.comments_count, user: user)
        end
      end
    end
  end
  