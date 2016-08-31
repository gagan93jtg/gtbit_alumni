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

  validates_presence_of :company_name, message: 'is requried'
  validates_presence_of :position, message: 'is requried'
  validates_presence_of :compensation, message: 'is requried'
  validates_presence_of :location, message: 'is requried'
  validates_presence_of :job_type, message: 'is requried'

  validates_numericality_of :experience_in_months, :greater_than_or_equal_to => 0,
  :less_than_or_equal_to => 480, :message => "is out of range. Do you think somebody will work "\
  "in IT after this much experience ?"

  validates_numericality_of :bond_period_in_months, :greater_than_or_equal_to => 0,
  :less_than_or_equal_to => 60, :message => "is out of range. Do you think somebody will work "\
  "in a single company for such long time ?"


  scope :public_activity, -> (id, limit) { where("user_id != #{id}").order('id DESC').limit(limit) }

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

  def update_job_post(params)
    job_post_params = params[:job_post]
    if was_job_post_updated?(job_post_params) && valid?
      save_post_in_redis
      update(company_name: job_post_params[:company_name],
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
        other_details: job_post_params[:other_details],
        is_edited: true)
    end
  end

  def comments
    Comment.where("post_id = #{id} AND post_type = #{Comment::POST_TYPE[:JOB]}")
  end

  private

  def was_job_post_updated?(job_post_params)
    !(are_attributes_same?(company_name               , job_post_params[:company_name]) &&
      are_attributes_same?(company_website            , job_post_params[:company_website]) &&
      are_attributes_same?(position                   , job_post_params[:position]) &&
      are_attributes_same?(compensation               , job_post_params[:compensation]) &&
      are_attributes_same?(experience_in_months       , job_post_params[:experience_in_months]) &&
      are_attributes_same?(bond_period_in_months      , job_post_params[:bond_period_in_months]) &&
      are_attributes_same?(location                   , job_post_params[:location]) &&
      are_attributes_same?(reporting_date_time        , job_post_params[:reporting_date_time]) &&
      are_attributes_same?(eligibility_criteria       , job_post_params[:eligibility_criteria]) &&
      are_attributes_same?(selection_process          , job_post_params[:selection_process]) &&
      are_attributes_same?(job_description            , job_post_params[:job_description]) &&
      are_attributes_same?(job_type                   , job_post_params[:job_type]) &&
      are_attributes_same?(other_details              , job_post_params[:other_details]))
  end

  def are_attributes_same?(original, updated)
    if (original.nil? && updated.nil?)
      return true
    elsif (original.nil? || updated.nil?)
      return false
    elsif (original.to_s.strip == updated.to_s.strip)
      return true
    else
      return false
    end
  end

  def save_post_in_redis
    return if is_edited == true

    redis_master = RedisConnection.initialize_redices[0]
    redis_post = self.to_json
    redis_master.HSET('JOB_POSTS', "ORIGINAL_#{id}", redis_post.to_json)
  end
end
