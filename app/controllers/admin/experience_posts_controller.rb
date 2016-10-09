class Admin::ExperiencePostsController < AdminController
  def index
    @experience_posts, @total_posts = get_experience_posts
  end

  private

  def get_experience_posts
    page = Utils.sanitize_page_number(params[:page])
    per_page = CONFIG['pagination_per_page'] || 10
    return ExperiencePost.order('id DESC').paginate(page: page, per_page: per_page), ExperiencePost.count
  end
end
