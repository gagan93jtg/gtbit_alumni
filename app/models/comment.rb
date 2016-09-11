class Comment < ActiveRecord::Base
  belongs_to :user
  after_save :update_subscribers_and_notifications

  validates :comment_string, length: { maximum: 65535 }
  validates_presence_of :comment_string, message: 'cannot be empty'

  POST_TYPE = { QUESTION: 1, EXPERIENCE: 2, JOB: 3 }

  def self.save_comment(user, params)
    comment_params = params[:comment]
    comment = user.comments.build(comment_string: comment_params[:comment_string],
                                  post_id: params[:post][:id], post_type: params[:post][:post_type])
    comment.save
  end

  def post
    if post_type == POST_TYPE[:QUESTION] || post_type == POST_TYPE[:EXPERIENCE]
      Post.find_by_id(post_id)
    elsif post_type == POST_TYPE[:JOB]
      JobPost.find_by_id(post_id)
    end
  end

  private

  def update_subscribers_and_notifications
    # This variable was created only because the association variable 'user_id' was confusing me
    commenter_id = user_id

    post_owner = post.user
    commenter = user
    subscribers = Notification::NotificationPipeline.get_post_subscribers(post_id)

    if commenter_id != post_owner.id && !subscribers.include?(commenter_id)
      Notification::NotificationPipeline.add_subscriber(post_id, commenter_id)
    end

    subscribers += [post_owner.id.to_s] if commenter_id != post_owner.id

    subscribers.each do |sub|
      next if sub.to_i == commenter_id
      message = "commented on "
      if post_owner == commenter
        message += "their own"
      elsif post_owner.id == sub.to_i
        message += "your"
      else
        if (post_type == POST_TYPE[:QUESTION] && post.is_anonymous == true)
          append_msg = "an anonymous"
        else
          append_msg = post_owner.full_name + "'s"
        end
        message += append_msg
      end
      push_notification_for_subscriber(sub, commenter_id, post_id, message)
    end
  end

  def push_notification_for_subscriber(sub, commenter_id, post_id, text)
    notification_info = {}
    notification_info['text'] = text
    notification_info['commenter_id'] = commenter_id
    notification_info['post_id'] = post_id
    notification_info['post_type'] = post_type
    notification_info['timestamp'] = Time.current.to_i
    Notification::NotificationPipeline.push_notification(sub, post_id, commenter_id, notification_info)
  end
end
