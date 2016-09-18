require File.expand_path('../../config/environment',  __FILE__)

redis = RedisConnection.initialize_redices[1]
User.all.each do |user|
  key = "UNREAD_NOTIFS:#{user.id}"
  not_count = redis.hlen(key)
  next if (not_count == 0 || not_count.nil? || user.receive_weekly_mailer == false)

  NotificationMailer.unread_notification_mailer(user, not_count).deliver_now
  puts "[#{Time.now}] Sent to #{user.full_name}"
end
