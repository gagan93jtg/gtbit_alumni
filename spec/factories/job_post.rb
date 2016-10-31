FactoryGirl.define do
  factory :job_post do
    company_name "Test Company"
    company_website "testcompany.com"
    position "Test position"
    compensation "Test LPA"
    experience_in_months 10
    bond_period_in_months 10
    location 'Ficticious'
    job_type 'Tech'
  end
end
