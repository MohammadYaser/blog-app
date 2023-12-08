FactoryBot.define do
    factory :post do
      title { Faker::Lorem.sentence(word_count: 5) }  # Example: Generates a random sentence with 5 words
      comments_counter { 0 }  # Assuming the default value for comments_counter is 0
      likes_counter { 0 }  # Assuming the default value for likes_counter is 0
  
      # Define associations
      association :author, factory: :user
  
      # Define any other attributes you have in your Post model
  
      # Define associations with comments and likes if needed
      transient do
        comments_count { 5 }  # Number of comments to create per post by default
        likes_count { 0 }     # Number of likes to create per post by default
      end
  
      after(:create) do |post, evaluator|
        create_list(:comment, evaluator.comments_count, post: post)
        create_list(:like, evaluator.likes_count, post: post)
      end
    end
  end
  