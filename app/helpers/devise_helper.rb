module DeviseHelper
  def devise_error_messages!
    if resource.errors && !resource.errors.full_messages.empty?
      return resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join.html_safe
    else
      return nil
    end
  end
end
