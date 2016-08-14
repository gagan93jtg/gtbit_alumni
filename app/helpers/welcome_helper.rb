module WelcomeHelper
  def asked_or_shared_experience(post)
    if post.post_type == Comment::POST_TYPE[:QUESTION]
      'asked'
    elsif post.post_type == Comment::POST_TYPE[:EXPERIENCE]
      'shared an experience'
    end
  end
end
