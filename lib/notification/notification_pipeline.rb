module Notification
	class NotificationPipeline
		@@redis_slave  = nil
		@@redis_master = nil

		def self.initialize_redices
			return unless @@redis_slave.nil? || @@redis_master.nil?

			master = CONFIG['redis_master']
			slave = CONFIG['redis_slave']
			@@redis_master = Redis.new(host: master['host'], port: master['port'], db: master['db'])
			@@redis_slave  = Redis.new(host: slave['host'], port: slave['port'], db: slave['db'])
		end

		def self.add_subscriber(post_id, sub_id)
			initialize_redices
			@@redis_master.sadd("POST_SUBSCRIBERS:#{post_id}", sub_id)
		end

		def self.remove_subscriber(post_id, sub_id)
			initialize_redices
			@@redis_master.srem("POST_SUBSCRIBERS:#{post_id}", sub_id)
		end

		def self.get_post_subscribers(post_id)
			initialize_redices
			@@redis_slave.smembers("POST_SUBSCRIBERS:#{post_id}")
		end

		def self.push_notification(subscriber, post_id, commenter_id, notification_info)
			initialize_redices
			key = "post#{post_id}:commenter#{commenter_id}"
			update_notification_count(subscriber,key)
			@@redis_master.hset("UNREAD_NOTIFS:#{subscriber}", key, notification_info.to_json)
		end

		def self.set_last_notification_checked_at(user_id)
			initialize_redices
			@@redis_master.hset('NOTIFICATION_LAST_CHECKED', "USER:user_id", Time.current.to_i)
		end

		def self.get_notifications(subscriber)
			initialize_redices
			notifications = @@redis_slave.hvals("UNREAD_NOTIFS:#{subscriber}")
			parsed_notifications = []

			notifications.each do |notification|
				parsed_notifications.push JSON.parse(notification)
			end

			parsed_notifications.sort_by { |n| n["timestamp"]}.reverse
		end

		def self.update_notification_count(subscriber,key)
			notification_last_checked = @@redis_slave.hget('NOTIFICATION_LAST_CHECKED', "USER:#{subscriber}")

			# We need latest thing, so get it from master
			existing_notification = @@redis_master.hget("UNREAD_NOTIFS:#{subscriber}", key)
			if existing_notification.nil? || notification_last_checked.nil?
				increment_notification_count(subscriber, 1)
			else
				timestamp = JSON.parse(existing_notification)['timestamp']
				increment_notification_count(subscriber) if timestamp < notification_last_checked
			end
		end

		def self.set_read_notification_to_zero(subscriber)
			initialize_redices
			@@redis_master.hset('UNREAD_NOTIFS', "USER:#{subscriber}", 0)
		end

		def self.increment_notification_count(subscriber, count)
			initialize_redices
			@@redis_master.hincrby('UNREAD_NOTIFS', "USER:#{subscriber}", count)
		end

		def self.get_notification_count(subscriber)
			initialize_redices
			@@redis_master.hget('UNREAD_NOTIFS', "USER:#{subscriber}")
		end

		##def self.get_notifications_length(subscriber)
		##	initialize_redices
		##	@@redis_slave.hlen("UNREAD_NOTIFS:#{subscriber}")
		##end
	end
end
