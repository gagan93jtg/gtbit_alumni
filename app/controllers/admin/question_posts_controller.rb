class Admin::QuestionPostsController < AdminController
  def index
    @question_posts, @total_posts = get_question_posts
  end

  private

  def get_question_posts
    page = Utils.sanitize_page_number(params[:page])
    per_page = CONFIG['pagination_per_page'] || 10
    return QuestionPost.order('id DESC').paginate(page: page, per_page: per_page), QuestionPost.count
  end
end
