class NotificationsController < ApplicationController
  before_filter :authenticate_user!
  after_filter :update_notification_details, :only => :index

  def index
    @notifications = Notification::NotificationPipeline.get_notifications(current_user.id)
    @notif_count = Notification::NotificationPipeline.get_notification_count(current_user.id)

  end

  def update_notification_details
    Notification::NotificationPipeline.set_last_notification_checked_at(current_user.id)
    Notification::NotificationPipeline.set_read_notification_to_zero(current_user.id)
  end
end
