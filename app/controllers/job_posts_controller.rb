class JobPostsController < ApplicationController
  before_filter :authenticate_user!

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
    redirect_to controller: 'errors', action: 'file_not_found' and return if @job_post.nil?
  end

  private

  def get_job_posts
    search_string = params['search_query']
    search_string = nil if search_string.blank?

    if search_string.nil?
      return JobPost.order('id DESC').last(10).reverse, true
    else
      return JobPost.where("company_name LIKE '%#{search_string}%' OR position LIKE '%#{search_string}%'"), false
    end
  end
end
