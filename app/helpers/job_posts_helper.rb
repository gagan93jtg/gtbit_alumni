module JobPostsHelper
  def create_update_job_post_options(form_type)
    if form_type == 'create'
      @url = '/job'
      @save_string = 'Create a Job post'
      @title = 'Create job post'
      @form_method = 'POST'
    elsif form_type == 'update'
      @url = job_path
      @save_string = 'Update a Job post'
      @title = 'Edit job post'
      @form_method = 'PUT'
    end
  end
end
