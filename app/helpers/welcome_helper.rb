module WelcomeHelper
  def asked_or_shared_experience(post)
    if post.post_type == Comment::POST_TYPE[:QUESTION]
      'asked'
    elsif post.post_type == Comment::POST_TYPE[:EXPERIENCE]
      'shared an experience'
    end
  end

  def is_anonymous(post_id)
    post = Post.find_by_id(post_id)
    return (post.nil? || post.is_anonymous == false) ? false : true
  end

  def is_owner(post_id, commenter_id)
    post = Post.find_by_id(post_id)
    return false unless post

    (post.user_id == commenter_id)? true : false
  end

  def user_has_avatar?(user_id)
    user = User.find_by_id(user_id)
    if user.nil?
      return false
    else
      return user.avatar?
    end
  end
end
