class QueriesController < ApplicationController
  before_filter :authenticate_user!

  def new
    @query = Query.new
  end

  def create
    Query.save_query(current_user, params)
    redirect_to root_path
  end

  def show
    @query = Query.find_by_id(params[:id])
    redirect_to controller: "errors", action: "file_not_found" and return unless @query
  end

  def edit
    @query = Query.find_by_id(params[:id])
    redirect_to controller: "errors", action: "file_not_found" and return unless @query
    redirect_to controller: "errors", action: "unprocessable" and return unless current_user.id == @query.user_id
  end

  def update
    query = Query.find(params[:id])
    redirect_to controller: "errors", action: "file_not_found" and return unless query
    redirect_to controller: "errors", action: "unprocessable" and return unless current_user.id == query.user_id

    query.update_query(params)
    redirect_to root_path
  end

  def edit_history
    query = Query.find(params[:id])
    redirect_to controller: "errors", action: "file_not_found" and return unless query
    render json: query.query_histories.to_json and return
  end
end
