class PostsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @posts, @show_recent_posts = get_posts
  end

  def new
    @post = Post.new
  end

  def create
    Post.save_post(current_user, params)
    redirect_to root_path
  end

  def show
    @post = Post.find_by_id(params[:id])
    redirect_to controller: 'errors', action: 'file_not_found' and return if @post.nil?
  end

  def edit
    @post = Post.find_by_id(params[:id])
    redirect_to controller: 'errors', action: 'file_not_found' and return unless @post
    redirect_to controller: 'errors', action: 'unprocessable' and return if current_user.id != @post.user_id
  end

  def update
    post = Post.find(params[:id])
    redirect_to controller: 'errors', action: 'file_not_found' and return unless post
    redirect_to controller: 'errors', action: 'unprocessable'and return if current_user.id != post.user_id

    post.update_post(params)
    redirect_to post_path(post.id)
  end

  def edit_history
    post = Post.find(params[:id])
    redirect_to controller: 'errors', action: 'file_not_found' and return unless post
    render json: post.post_histories.to_json
    return
  end

  private

  def get_posts
    search_string = params['search_query']
    search_string = nil if search_string.blank?

    if search_string.nil?
      return Post.order('id DESC').last(10).reverse, true
    else
      return Post.where("query_string LIKE '%#{search_string}%'"), false
    end
  end
end
