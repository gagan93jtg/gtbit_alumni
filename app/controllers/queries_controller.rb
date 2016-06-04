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
  end

  def edit
    @query = Query.find_by_id(params[:id])
  end

  def update
    query = Query.find(params[:id])
    query.update_query(params)
    redirect_to root_path
  end
end
