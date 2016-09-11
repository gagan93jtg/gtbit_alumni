class NotificationsController < ApplicationController
  before_filter :authenticate_user!

  def index
    unread_nfs, read_nfs = Notification::NotificationPipeline.get_notifications(current_user.id)
    @notifications = unread_nfs + read_nfs
  end
end
