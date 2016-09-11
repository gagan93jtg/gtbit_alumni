class CommentsController < ApplicationController
  before_filter :authenticate_user!

  def create
    Comment.save_comment(current_user, params)

    if params[:post][:post_type].to_i == Comment::POST_TYPE[:QUESTION]
      redirect_to controller: 'question_posts', action: 'show', id: params[:post][:id] and return
    elsif params[:post][:post_type].to_i == Comment::POST_TYPE[:EXPERIENCE]
      redirect_to controller: 'experience_posts', action: 'show', id: params[:post][:id] and return
    elsif params[:post][:post_type].to_i == Comment::POST_TYPE[:JOB]
      redirect_to controller: 'job_posts', action: 'show', id: params[:post][:id] and return
    end
  end
end
