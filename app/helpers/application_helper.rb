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

  def get_domain_name
    if Rails.env == 'development'
      'http://gtbitalumnilocal.in'
    elsif Rails.env == 'staging'
      'http://staging.gtbitalumni.in'
    else
      'https://www.gtbitalumni.in'
    end
  end
end
