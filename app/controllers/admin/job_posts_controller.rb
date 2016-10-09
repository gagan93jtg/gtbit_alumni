class Admin::JobPostsController < AdminController
  def index
    @job_posts, @total_posts = get_job_posts
  end

  private

  def get_job_posts
    page = Utils.sanitize_page_number(params[:page])
    per_page = CONFIG['pagination_per_page'] || 10
    return JobPost.order('id DESC').paginate(page: page, per_page: per_page), JobPost.count
  end
end
