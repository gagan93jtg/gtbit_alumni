class FaqsController < ApplicationController
  def index
    @faqs = Faq.paginate(page: params[:page], per_page: 10)
  end

  def show
    @faq = Faq.find_by_id(params[:id])
    redirect_to controller: 'errors', action: 'file_not_found' and return if @faq.nil?
  end
end
