class NotificationsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @notifications = Notification::NotificationPipeline.pull_notifications(current_user.id)
  end
end
