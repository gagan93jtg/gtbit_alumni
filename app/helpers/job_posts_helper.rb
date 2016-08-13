module JobPostsHelper
  def create_update_job_post_options(form_type)
    if form_type == 'create'
      @url = job_posts_path
      @save_string = 'Create a Job post'
      @title = 'Please provide appropriate information in each field and we will create a job post out it'
      @form_method = 'POST'
    elsif form_type == 'update'
      @url = job_posts_path + '/' + @job_post.id.to_s
      @save_string = 'Update a Job post'
      @title = @save_string
      @form_method = 'PUT'
    end
  end
end
