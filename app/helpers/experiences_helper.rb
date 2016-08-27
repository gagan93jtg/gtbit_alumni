module ExperiencesHelper
  def create_update_experience_form_options(form_type)
    if form_type == 'create'
      @url = '/experience'
      @save_string = 'Save'
      @form_method = 'POST'
    elsif form_type == 'update'
      @url = experience_path
      @save_string = 'Update query'
      @form_method = 'PUT'
    end
  end
end
