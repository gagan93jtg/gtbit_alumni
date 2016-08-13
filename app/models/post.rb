class Post < ActiveRecord::Base
  belongs_to :user

  validates :query_string, length: { maximum: 65535 }
  validates :tags, length: { maximum: 255 }

  scope :public_activity, -> (id) { where("user_id != #{id}") }
  has_many :post_histories

  def self.save_post(user, params)
    post_params = params[:post]
    post = user.posts.build(query_string: post_params[:query_string],
                            tags: post_params[:tags],
                            is_anonymous: post_params[:is_anonymous],
                            post_type: post_params[:post_type])
    post.save
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
    old_tags = tags.split(',').sort
    new_tags = post_params[:tags].split(',').sort
    old_string = query_string
    new_string = post_params[:query_string]
    (old_tags == new_tags && old_string == new_string) ? false : true
  end
end
