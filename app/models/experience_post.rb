class ExperiencePost < Post
  def self.all
    Post.where(post_type: Comment::POST_TYPE[:EXPERIENCE])
  end
end
