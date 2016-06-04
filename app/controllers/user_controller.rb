class UserController < ApplicationController
  #check user's login status, controller is accessible only if user is logged in
  before_filter :authenticate_user!

  def index
    @your_activity = current_user.queries
    @public_activity = Query.where("user_id != #{current_user.id}")
  end

  def edit

  end

  def update
    current_user.update_details(params[:user])
    redirect_to edit_user_path(params[:id])
  end

  def trusted
    @trusted_members = User.all
    Rails.logger.info "\n\n\n\n\n\n\n\nGot a hit\n\n\n\n\n\n\n\n"
  end

  def show

  end
end
