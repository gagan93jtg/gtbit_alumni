class FaqsController < ApplicationController
  def index
    @faqs = Faq.paginate(page: params[:page], per_page: 10)
  end
end
