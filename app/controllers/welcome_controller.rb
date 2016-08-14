class WelcomeController < ApplicationController
  # This is important : authentication will be done for index action ONLY !!!!!
  # Take care while adding new actions in this controller
  before_filter :authenticate_user!, only: [:index]

  def index
    @your_activity = current_user.posts.order("id desc").first(5)
    @public_activity = Post.public_activity(current_user.id, 5)
  end

  def contact_us_mail
    UserMailer.contact_us_mail(params).deliver_now

    respond_to do |format|
      format.js {}
    end
  end

  def report_bug
    UserMailer.report_bug_mail(params).deliver_now

    respond_to do |format|
      format.js {}
    end
  end
end
