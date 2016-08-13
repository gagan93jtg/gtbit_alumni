class ExperiencePost < Post
  default_scope { where(post_type: Comment::POST_TYPE[:EXPERIENCE]) }
end
