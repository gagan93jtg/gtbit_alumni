class ResponsesController < ApplicationController

  before_filter :authenticate_user!

  def create
    Response.save_response(current_user, params)
    redirect_to :controller => "queries", :action => "show", :id => params[:query][:id]
  end
end
