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
    if params[:id] == 'anonymous'
      @user = User.find_by_email('anonymous_user@gtbitalumni.in')
    else
      @user = User.find_by_id(params[:id])
    end
    redirect_to controller: 'errors', action: 'file_not_found' and return unless @user
  end

  def update_password
    @response = current_user.update_password(params)
    sign_in(current_user, :bypass => true) if @response == 'Password Updated !'
    respond_to do |format|
      format.js {}
    end
  end

  # def crop
  #
  # end

  # def save_crop
  #
  # end

  private

  def get_users
    page = Utils.sanitize_page_number(params[:page])
    Rails.logger.error "\n\n\n\npagenumber after sanitize_page_number : #{page}"
    search_string = params['search_query']
    search_string = nil if search_string.blank?
    per_page = CONFIG['pagination_per_page'] || 10

    if search_string.nil?
      return User.paginate(page: page, per_page: per_page), true
    else
      return User.where("first_name LIKE '%#{search_string}%' OR "\
        "last_name LIKE '%#{search_string}%' OR "\
        "email LIKE '%#{search_string}%'").paginate(page: params[:page], per_page: per_page), false
    end
  end
end
