class JobPost < ActiveRecord::Base
  belongs_to :user

  validates :company_name, length: { maximum: 255 }
  validates :company_website, length: { maximum: 255 }
  validates :position, length: { maximum: 255 }
  validates :compensation, length: { maximum: 255 }
  validates :location, length: { maximum: 255 }
  validates :reporting_date_time, length: { maximum: 255 }
  validates :eligibility_criteria, length: { maximum: 65535 }
  validates :selection_process, length: { maximum: 65535 }
  validates :job_description, length: { maximum: 65535 }
  validates :job_type, length: { maximum: 255 }
  validates :other_details, length: { maximum: 255 }

  def self.save_job_post(user, params)
    job_post_params = params[:job_post]
    job_post = user.job_posts.build(company_name: job_post_params[:company_name],
                            company_website: job_post_params[:company_website],
                            position: job_post_params[:position],
                            compensation: job_post_params[:compensation],
                            experience_in_months: job_post_params[:experience_in_months],
                            bond_period_in_months: job_post_params[:bond_period_in_months],
                            location: job_post_params[:location],
                            reporting_date_time: job_post_params[:reporting_date_time],
                            eligibility_criteria: job_post_params[:eligibility_criteria],
                            selection_process: job_post_params[:selection_process],
                            job_description: job_post_params[:job_description],
                            job_type: job_post_params[:job_type],
                            other_details: job_post_params[:other_details])
    job_post.save
    job_post
  end

  def comments
    Comment.where("post_id = #{id} AND post_type = #{Comment::POST_TYPE[:JOB]}")
  end
end
