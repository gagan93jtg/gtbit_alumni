class ExperiencePostsController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update]

  def index
    @posts, @show_recent_posts = get_experience_posts
  end

  def new
    @post = ExperiencePost.new
  end

  def create
    @post = ExperiencePost.save_post(current_user, params)
    unless @post.errors.any?
      redirect_to experience_path(@post.id)
    else
      render action: :new
    end
  end

  def show
    @post = ExperiencePost.find_by_id(params[:id])
    @comments = get_comments(@post) unless @post.nil?
    redirect_to controller: 'errors', action: 'file_not_found' and return if @post.nil?
  end

  def edit
    @post = ExperiencePost.find_by_id(params[:id])
    redirect_to controller: 'errors', action: 'file_not_found' and return unless @post
    redirect_to controller: 'errors', action: 'unprocessable' and return if current_user.id != @post.user_id
  end

  def update
    post = ExperiencePost.find(params[:id])
    redirect_to controller: 'errors', action: 'file_not_found' and return unless post
    redirect_to controller: 'errors', action: 'unprocessable'and return if current_user.id != post.user_id

    post.update_post(params)

    unless post.errors.any?
      redirect_to experience_path(post.id)
    else
      @post = post
      render action: :edit
    end
  end

  private

  def get_experience_posts
    search_string = params['search_query']
    search_string = nil if search_string.blank?

    if search_string.nil?
      return ExperiencePost.order('id DESC').last(10).reverse, true
    else
      return ExperiencePost.where("query_string LIKE ?", "%#{search_string}%"), false
    end
  end

  def get_comments(post)
    page = Utils.sanitize_page_number(params[:page])
    per_page = CONFIG['pagination_per_page'] || 10
    post.comments.paginate(page: page, per_page: per_page)
  end
end
