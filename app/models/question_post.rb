class QuestionPost < Post

  def self.all
    Post.where(post_type: Comment::POST_TYPE[:QUESTION])
  end
end
