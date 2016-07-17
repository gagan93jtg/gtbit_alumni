class WelcomeController < ApplicationController
  # This is important, authentication will be done for index action ONLY !!!!!
  # Take care while adding new actions in this controller
  before_filter :authenticate_user!, only: [:index]

  def index
    @your_activity = current_user.posts
    @public_activity = Post.public_activity(current_user.id)
  end

  def contact_us_mail
    UserMailer.contact_us_mail(params)

    respond_to do |format|
      format.js {}
    end
  end

  def report_bug
    Rails.logger.info "Hola got a hit : #{params.inspect}"
    UserMailer.contact_us_mail(params)
    Rails.logger.info "Hola sent mail"

    respond_to do |format|
      format.js {}
    end
  end
end
