module ApplicationHelper
  def notif_count
    Notification::NotificationPipeline.get_unread_notifications_count(current_user.id)
  end
end
