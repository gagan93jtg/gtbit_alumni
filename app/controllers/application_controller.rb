class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :exception
  before_filter :add_user_details_to_exception_notification_mail

  private

  # DO NOT TOUCH : For exception_notification gem
  def add_user_details_to_exception_notification_mail
    request.env["exception_notifier.exception_data"] =
    {
      :current_user => current_user
    }
  end
end
