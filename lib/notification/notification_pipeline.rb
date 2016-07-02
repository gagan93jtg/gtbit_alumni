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

    ############## SUBSCRIBER SET METHODS
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
    ##############

    ############## [UN]READ_NOTIFICATION HASH METHODS
    def self.get_unread_notifications_count(subscriber)
      initialize_redices
      @@redis_slave.hlen("UNREAD_NOTIFS:#{subscriber}")
    end

    def self.push_notification(subscriber, post_id, commenter_id, notification_info)
      initialize_redices
      key = "post#{post_id}:commenter#{commenter_id}"
      @@redis_master.hset("UNREAD_NOTIFS:#{subscriber}", key, notification_info.to_json)
    end

    def self.get_notifications(subscriber)
      initialize_redices
      unread_notifications = @@redis_slave.hgetall("UNREAD_NOTIFS:#{subscriber}")
      read_notifications = @@redis_slave.hvals("READ_NOTIFS:#{subscriber}")
      parsed_unread_notifications = []
      parsed_read_notifications = []

      read_notifications.each do |notification|
        parsed_read_notifications.push JSON.parse(notification)
      end

      unread_notifications.each do |key, value|
        parsed_unread_notifications.push JSON.parse(value)
        @@redis_master.hset("READ_NOTIFS:#{subscriber}", key, value)
        @@redis_master.hdel("UNREAD_NOTIFS:#{subscriber}", key)
      end

      return parsed_unread_notifications.sort_by { |n| n["timestamp"]}.reverse,
             parsed_read_notifications.sort_by { |n| n["timestamp"]}.reverse
    end
    ##############

  end
end
