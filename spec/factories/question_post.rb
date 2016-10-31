FactoryGirl.define do
  factory :question_post, class: Post do
    query_string "This is a sample question post"
    tags "test, post, simple, tags"
    post_type Comment::POST_TYPE[:QUESTION]
  end

  factory :anonymous_post, class: Post do
    query_string "This is an anonymous question post"
    tags "test, post, simple, tags"
    post_type Comment::POST_TYPE[:QUESTION]
    is_anonymous true
  end
end
