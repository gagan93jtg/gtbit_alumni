module Notification
	class NotificationPipeline
		@@redis_read  = nil
		@@redis_write = nil

		def self.initialize_redices
			return unless @@redis_read.nil? || @@redis_write.nil?

			master = CONFIG['redis_master']
			slave = CONFIG['redis_slave']

			@@redis_write = Redis.new(host: master['host'], port: master['port'], db: master['db'])
			@@redis_read  = Redis.new(host: slave['host'], port: slave['port'], db: slave['db'])
		end

		def self.add_subscriber(post_id, sub_id)
			initialize_redices
			@@redis_write.sadd("POST_SUBSCRIBERS:#{post_id}", sub_id)
		end

		def self.remove_subscriber(post_id, sub_id)
			initialize_redices
			@@redis_write.srem("POST_SUBSCRIBERS:#{post_id}", sub_id)
		end

		def self.get_post_subscribers(post_id)
			initialize_redices
			@@redis_read.smembers("POST_SUBSCRIBERS:#{post_id}")
		end

		def self.push_notification(user_id, notification_info)
			initialize_redices
			@@redis_write.lpush("UNREAD_NOTIFS:#{user_id}", notification_info.to_json)
		end

		def self.pull_notifications(user_id)
			initialize_redices
			@@redis_read.lrange("UNREAD_NOTIFS:#{user_id}", 0, -1)

			###@@redis_write.multi do
			###	element = @@redis_write.rpop("UNREAD_NOTIFS:#{user_id}", 0, 1)
			###	@@redis_write.l("UNREAD_NOTIFS:#{user_id}", 0, 1)
			###end
		end

		def self.get_unread_notifications_length(user_id)
			initialize_redices
			@@redis_read.llen("UNREAD_NOTIFS:#{user_id}")
		end

		def self.get_read_notifications_length(user_id)
			initialize_redices
			@@redis_read.llen("READ_NOTIFS:#{user_id}")
		end
	end
end
