require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do

  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = FactoryGirl.create(:user)
    sign_in @user
  end

  it 'calls basic methods of welcome controller' do
    post = FactoryGirl.create(:question_post)
    post.user = @user
    post.save

    get :index
    expect(response).to have_http_status(:success)

    get :team

    params = { full_name: 'Test user', email: 'test@example.com', message: 'Some sample text',
               format: 'js' }

    response = xhr :post, :contact_us_mail, params: params
    expect(response).to have_http_status(:success)

    response = xhr :post, :report_bug, params: params
    expect(response).to have_http_status(:success)

    params = { first_name: 'Test', last_name: 'user' , email: 'test@example.com' , format: 'js'}

    response = xhr :post, :request_account, params: params
    expect(response).to have_http_status(:success)
  end
end
