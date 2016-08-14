class Post < ActiveRecord::Base
  belongs_to :user

  validates :query_string, length: { maximum: 65535 }
  validates :tags, length: { maximum: 255 }

  scope :public_activity, -> (id, limit) { where("user_id != #{id}").order('id DESC').limit(limit) }
  has_many :post_histories

  def self.save_post(user, params)
    post_params = params[:post]
    post = user.posts.build(query_string: post_params[:query_string],
      tags: post_params[:tags],
      is_anonymous: post_params[:is_anonymous],
      post_type: post_params[:post_type])
    post.save
    save_post_in_redis(post)
    post
  end

  def update_post(params)
    post_params = params[:post]
    if was_post_updated?(post_params)
      post_history = post_histories.build(query_string: query_string,
        tags: tags, user_id: user_id)
      post_history.save
      update(query_string: post_params[:query_string], tags: post_params[:tags])
    end
  end

  def comments
    Comment.where("post_id = #{id} AND post_type = #{post_type}")
  end

  private

  def was_post_updated?(post_params)
    old_tags = tags.split(',')
    old_tags.each { |tag| tag.strip! }
    old_tags.sort

    new_tags = post_params[:tags].strip.split(',')
    new_tags.each { |tag| tag.strip! }
    new_tags.sort

    old_string = query_string
    new_string = post_params[:query_string].strip
    (old_tags == new_tags && old_string == new_string) ? false : true
  end

  def self.save_post_in_redis(post)
    return if post.errors.any? || post.post_type == Comment::POST_TYPE[:QUESTION]

    redis_master = RedisConnection.initialize_redices[0]
    redis_master.HSET('EXPERIENCE_POSTS', "ORIGINAL_#{post.id}", post.query_string.to_json + '  ' +
      post.tags.to_json)
  end
end
