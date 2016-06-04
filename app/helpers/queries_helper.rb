module QueriesHelper
  def is_anonymous?(query)
    return "(anonymously)" if query.is_anonymous
    return ""
  end

  def asked_by(user)
    return "You" if user.id == current_user.id
    return user.full_name
  end

  def create_update_form_options(form_type)
    if form_type == "create"
      @url = queries_path()
      @save_string = "Post query"
      @form_method = "POST"
    elsif form_type == "update"
      @url = queries_path() + "/" + @query.id.to_s
      @save_string = "Update query"
      @form_method = "PUT"
    end


  end
end
