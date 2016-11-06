class JobPostsController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update]

  def index
    @job_posts, @show_recent_posts = get_job_posts
  end

  def new
    @job_post ||= JobPost.new
  end

  def create
    @job_post = JobPost.save_job_post(current_user, params)
    unless @job_post.errors.any?
      redirect_to job_path(@job_post.id)
    else
      render action: :new
    end
  end

  def show
    @job_post = JobPost.find_by_id(params[:id])
    @comments = get_comments(@job_post) unless @job_post.nil?
    redirect_to controller: 'errors', action: 'file_not_found' and return if @job_post.nil?
  end

  def edit
    @job_post = JobPost.find_by_id(params[:id])
    redirect_to controller: 'errors', action: 'file_not_found' and return unless @job_post
    redirect_to controller: 'errors', action: 'unprocessable' and return if current_user.id != @job_post.user_id
  end

  def update
    job_post = JobPost.find(params[:id])
    redirect_to controller: 'errors', action: 'file_not_found' and return unless job_post
    redirect_to controller: 'errors', action: 'unprocessable'and return if current_user.id != job_post.user_id

    job_post.update_job_post(params)

    unless job_post.errors.any?
      redirect_to job_path(job_post.id)
    else
      @job_post = job_post
      render action: :edit
    end
  end


  private

  def get_job_posts
    search_string = params['search_query']
    search_string = nil if search_string.blank?

    if search_string.nil?
      return JobPost.order('id DESC').last(10).reverse, true
    else
      return JobPost.where("company_name LIKE ? OR position LIKE ?", "%#{search_string}%",
        "%#{search_string}%"), false
    end
  end

  def get_comments(post)
    page = Utils.sanitize_page_number(params[:page])
    per_page = CONFIG['pagination_per_page'] || 10
    post.comments.paginate(page: page, per_page: per_page)
  end
end
