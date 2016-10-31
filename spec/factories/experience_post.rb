FactoryGirl.define do
  factory :experience_post do
    query_string "This is a sample experience post"
    tags "test, post, experience"
    post_type Comment::POST_TYPE[:EXPERIENCE]
  end
end
