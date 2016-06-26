class PostsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @post = Post.new
  end

  def create
    Post.save_post(current_user, params)
    redirect_to root_path
  end

  def show
    @post = Post.find_by_id(params[:id])
    redirect_to controller: 'errors', action: 'file_not_found' && return unless @post
  end

  def edit
    @post = Post.find_by_id(params[:id])
    redirect_to controller: 'errors', action: 'file_not_found' && return unless @post
    redirect_to controller: 'errors', action: 'unprocessable' && return unless
      current_user.id == @post.user_id
  end

  def update
    post = Post.find(params[:id])
    redirect_to controller: 'errors', action: 'file_not_found' && return unless post
    redirect_to controller: 'errors', action: 'unprocessable' && return unless
      current_user.id == post.user_id

    post.update_post(params)
    redirect_to root_path
  end

  def edit_history
    post = Post.find(params[:id])
    redirect_to controller: 'errors', action: 'file_not_found' && return unless post
    render json: post.post_histories.to_json
    return
  end
end
