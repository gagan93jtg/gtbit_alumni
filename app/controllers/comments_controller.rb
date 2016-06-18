class CommentsController < ApplicationController
  before_filter :authenticate_user!

  def create
    Comment.save_comment(current_user, params)
    redirect_to controller: 'posts', action: 'show', id: params[:post][:id]
  end
end
