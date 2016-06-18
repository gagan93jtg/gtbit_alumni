class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :post
	after_save :update_subscribers_and_notifications

	def self.save_comment(user, params)
		comment_params = params[:comment]
		comment = user.comments.build(comment_string: comment_params[:comment_string],
			                            post_id: params[:post][:id])
		comment.save
	end

	private

	def update_subscribers_and_notifications
		post_owner = Post.find_by_id(post_id).user
		commenter = User.find_by_id(user_id)

		Notification::NotificationPipeline.add_subscriber(post_id, user_id) if user_id != post_owner.id

		subscribers = Notification::NotificationPipeline.get_post_subscribers(post_id)
		if user_id != post_owner.id
			subscribers -= [user_id.to_s]
			subscribers += [post_owner.id.to_s]
		end
		subscribers.each do |sub|
			message = "#{commenter.full_name} commented on "
			if post_owner == commenter
				message += "their own"
			elsif post_owner.id == sub.to_i
				message += "your"
			else
				message += post_owner.full_name + "'s"
			end
			push_notification_for_subscriber(sub, post_id, message)
		end
	end

	def push_notification_for_subscriber(sub, post_id, message)
		notification_info = {}
		notification_info[:text] = message
		notification_info[:post_id] = post_id
		notification_info[:timestamp] = Time.current.to_i
		Notification::NotificationPipeline.push_notification(sub, notification_info)
	end
end
