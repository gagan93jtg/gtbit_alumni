require 'rails_helper'

RSpec.describe JobPost, type: :model do
  let(:job_post) { FactoryGirl.build(:job_post) }
  let(:user)     { FactoryGirl.create(:user) }
  let(:comment)  { FactoryGirl.build(:comment) }

  it 'saves a new job post' do
    params = { company_name: 'ABCD', company_website: 'www.abcd.com', position: 'SSD',
      compensation: 'X LPA', experience_in_months: 1, bond_period_in_months: 1, location: 'XYZ',
      reporting_date_time: 'Date Month Year Hour:Min', eligibility_criteria: 'Lorem ipsum',
      selection_process: 'Lorem ipsum', job_description: 'Lorem ipsum', job_type: 'Lorem ipsum',
      other_details: 'Lorem ipsum'
    }

    saved_job_post = JobPost.save_job_post(user, { job_post: params })
    retrieved_job_post = JobPost.last

    expect(saved_job_post).to eq(retrieved_job_post)

    expect(retrieved_job_post.company_name).to eq('ABCD')
    expect(retrieved_job_post.company_website).to eq('www.abcd.com')
    expect(retrieved_job_post.position).to eq('SSD')
    expect(retrieved_job_post.compensation).to eq('X LPA')
    expect(retrieved_job_post.experience_in_months).to eq(1)
    expect(retrieved_job_post.bond_period_in_months).to eq(1)
    expect(retrieved_job_post.location).to eq('XYZ')
    expect(retrieved_job_post.reporting_date_time).to eq('Date Month Year Hour:Min')
    expect(retrieved_job_post.eligibility_criteria).to eq('Lorem ipsum')
    expect(retrieved_job_post.selection_process).to eq('Lorem ipsum')
    expect(retrieved_job_post.job_description).to eq('Lorem ipsum')
    expect(retrieved_job_post.job_type).to eq('Lorem ipsum')
    expect(retrieved_job_post.other_details).to eq('Lorem ipsum')

    params.merge!({ ignore_date_time: 'on' })
    saved_job_post = JobPost.save_job_post(user, { job_post: params })

    expect(JobPost.last.reporting_date_time).to eq('not known')
  end

  it 'updates all attributes job post' do
    params = { company_name: 'ABCD', company_website: 'www.abcd.com', position: 'SSD',
      compensation: 'X LPA', experience_in_months: 1, bond_period_in_months: 1, location: 'XYZ',
      reporting_date_time: 'Date Month Year Hour:Min', eligibility_criteria: 'Lorem ipsum',
      selection_process: 'Lorem ipsum', job_description: 'Lorem ipsum', job_type: 'Lorem ipsum',
      other_details: 'Lorem ipsum'
    }

    job_post.update_job_post({ job_post: params })

    expect(job_post.company_name).to eq('ABCD')
    expect(job_post.company_website).to eq('www.abcd.com')
    expect(job_post.position).to eq('SSD')
    expect(job_post.compensation).to eq('X LPA')
    expect(job_post.experience_in_months).to eq(1)
    expect(job_post.bond_period_in_months).to eq(1)
    expect(job_post.location).to eq('XYZ')
    expect(job_post.reporting_date_time).to eq('Date Month Year Hour:Min')
    expect(job_post.eligibility_criteria).to eq('Lorem ipsum')
    expect(job_post.selection_process).to eq('Lorem ipsum')
    expect(job_post.job_description).to eq('Lorem ipsum')
    expect(job_post.job_type).to eq('Lorem ipsum')
    expect(job_post.other_details).to eq('Lorem ipsum')

    params.merge!({ ignore_date_time: 'on' })
    job_post.update_job_post({ job_post: params })
    job_post.reload

    expect(job_post.reporting_date_time).to eq('not known')
  end

  it 'retrieves comments of a jobpost' do
    job_post.user = user
    job_post.save

    expect(job_post.comments).to eq([])

    comment.post_type = Comment::POST_TYPE[:JOB]
    comment.post_id = job_post.id
    comment.user = user
    comment.save

    expect(job_post.comments).to eq([comment])
  end
end
