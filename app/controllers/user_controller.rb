class UserController < ApplicationController
  before_filter :authenticate_user!

  def index
    @your_activity = current_user.posts
    @public_activity = Post.where("user_id != #{current_user.id}")
  end

  def edit
  end

  def update
    current_user.update_details(params[:user])
    redirect_to edit_user_path(params[:id])
  end

  def trusted
    @trusted_members = User.all
  end

  def show
  end
end
