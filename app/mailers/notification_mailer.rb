class NotificationMailer < ApplicationMailer
  def unread_notification_mailer(user, notifications_count)
    @user=user
    @notifications_count = notifications_count
    mail(to: user.email, subject: 'GTBIT Alumni Network - You have unread notifications')
  end
end
