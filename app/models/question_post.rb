class QuestionPost < Post
  default_scope { where(post_type: Comment::POST_TYPE[:QUESTION]) }
end
