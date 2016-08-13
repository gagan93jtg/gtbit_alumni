class JobPostsController < ApplicationController
  before_filter :authenticate_user!

  def index
  end

  def new
    @job_post ||= JobPost.new
  end

  def create
    @job_post = JobPost.save_job_post(current_user, params)
    unless @job_post.errors.any?
      redirect_to job_post_path(@job_post.id)
    else
      render action: :new
    end
  end

  def show
    @job_post = JobPost.find_by_id(params[:id])
    redirect_to controller: 'errors', action: 'file_not_found' and return if @job_post.nil?
  end
end
