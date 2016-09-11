module QuestionHelper
  def anonymous?(post)
    return '(anonymously)' if post.is_anonymous
    ''
  end

  def asked_by(user)
    return 'You' if user.id == current_user.id
    user.full_name
  end

  def create_update_question_form_options(form_type)
    if form_type == 'create'
      @url = posts_path
      @save_string = 'Post a query'
      @form_method = 'POST'
    elsif form_type == 'update'
      @url = posts_path + '/' + @post.id.to_s
      @save_string = 'Update query'
      @form_method = 'PUT'
    end
  end
end
