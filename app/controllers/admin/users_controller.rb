class Admin::UsersController < AdminController
  def index
    @users, @user_statistics = get_users
  end

  private

  def get_users
    page = Utils.sanitize_page_number(params[:page])
    per_page = CONFIG['pagination_per_page'] || 10
    user_statistics = get_user_statistics
    return User.order('id DESC').paginate(page: page, per_page: per_page), user_statistics
  end

  def get_user_statistics
    stats = {}
    stats[:total_users] = User.count
    stats[:active_users] = User.where(is_active: true).count
    stats[:never_opened] = User.where(last_sign_in_at: nil).count
    stats[:updated_profile_once] = User.where("created_at != updated_at").count
    stats[:subscribed_notification_mailer] = User.where(receive_weekly_mailer: true).count
    stats[:has_avatars] = User.where("avatar_file_name IS NOT NULL").count

    stats
  end
end
