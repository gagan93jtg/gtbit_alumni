class CreateJobPosts < ActiveRecord::Migration
  def change
    create_table :job_posts do |t|
      t.references :user

      t.string    :company_name, default: ''
      t.string    :company_website, default: ''
      t.string    :position, default: ''
      t.string    :compensation, default: ''
      t.integer   :experience_in_months
      t.integer   :bond_period_in_months
      t.string    :location, default: ''
      t.string    :reporting_date_time, default: ''
      t.text      :eligibility_criteria
      t.text      :selection_process
      t.text      :job_description
      t.string    :job_type, default: ''
      t.string    :other_details, default: ''
      t.boolean   :edited, default: false

      t.timestamps
    end
    add_index :job_posts, :user_id
    add_index :job_posts, :company_name
    add_index :job_posts, :experience_in_months
    add_index :job_posts, :location
  end
end
