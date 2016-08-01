class UserController < ApplicationController
  before_filter :authenticate_user!

  def index
    @users, @show_all_users = get_users
  end

  def update
    current_user.update_details(params[:user])

    if current_user.errors.any?
      render action: :edit
    else
      redirect_to user_path(params[:id])
    end

    # elsif !params[:user][:avatar].blank?
    #  redirect_to controller: 'user', action: 'crop', id: current_user.id
  end

  def show
    @user = User.find_by_id(params[:id])
    redirect_to controller: 'errors', action: 'file_not_found' and return unless @user
  end

  # def crop
  #
  # end

  # def save_crop
  #
  # end

  private

  def get_users
    search_string = params['search_query']
    search_string = nil if search_string.blank?

    if search_string.nil?
      return User.paginate(page: params[:page], per_page: 3), true
    else
      return User.where("first_name LIKE '%#{search_string}%' OR "\
        "last_name LIKE '%#{search_string}%' OR "\
        "email LIKE '%#{search_string}%'").paginate(page: params[:page], per_page: 3), false
    end
  end
end
