module ApplicationHelper
  def notif_count
    Notification::NotificationPipeline.get_unread_notifications_count(current_user.id)
  end

  def format_attribute(attr)
    if attr == :query_string
      return 'Post string'
    elsif attr == :tags
      return ''
    end
    return attr.to_s.split("_").join(" ").camelize
  end
end
