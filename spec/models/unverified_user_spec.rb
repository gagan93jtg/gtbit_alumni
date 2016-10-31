require 'rails_helper'

RSpec.describe UnverifiedUser, type: :model do
  let(:unverified_user) { FactoryGirl.build :unverified_user }

  it 'will not register a new user because of blank email' do
    unverified_user.email = ''
    expect(unverified_user).to be_invalid
  end

  it 'will not register a new user because of blank first_name' do
    unverified_user.first_name = ''
    expect(unverified_user).to be_invalid
  end

  it 'will not register a new user because of blank last_name' do
    unverified_user.last_name = ''
    expect(unverified_user).to be_invalid
  end

  it 'will try to create an unverified user' do
    params = { first_name: 'Test', last_name: 'User', email: 'abcd@example.com', batch: 'ABCDEFGH' }
    return_msg = UnverifiedUser.create_unverified_user(params)
    expect(return_msg).to eq('Success')

    params[:first_name] = nil
    return_msg = UnverifiedUser.create_unverified_user(params)
    expect(return_msg).to eq('Missing required fields. Fields marked * are compulsory')

    params[:first_name] = 'Test'
    return_msg = UnverifiedUser.create_unverified_user(params)
    expect(return_msg).to eq('Email id already in use')

    long_and_stupid_field = 'very long and stupid field crossing 255 characters' +
    'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod' +
    'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod' +
    'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod' +
    'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod' +
    'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod' +
    'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod'

    params[:first_name] = long_and_stupid_field
    params[:email] = 'new_user@example.com'
    return_msg = UnverifiedUser.create_unverified_user(params)
    expect(return_msg.class).to eq(Array)
  end

  it 'will try to create unverified_user and move it to verified user' do
    params = { first_name: 'Test', last_name: 'User', email: 'abcd@example.com', batch: 'ABCDEFGH' }
    return_msg = UnverifiedUser.create_unverified_user(params)
    expect(return_msg).to eq('Success')

    UnverifiedUser.last.move_to_verified_user

    # as user is moved succesfully, there should be zero unverified users
    expect(UnverifiedUser.last).to eq(nil)

    params[:email] = 'new_user@example.com'
    UnverifiedUser.create_unverified_user(params)

    # Now, create a new verified user with an email id which is same as this email id, now this
    # unverified user cannot be moved to verified user. Though at the time of creation, his email id
    # was not in user's model but before verification, it is there.

    return_msg = User.create_user(params[:first_name], params[:last_name], params[:email])
    expect(return_msg).to eq(true)

    last_unverified_user = UnverifiedUser.last
    last_unverified_user.move_to_verified_user

    # As this is an error case, unverified user should not get deleted

    expect(UnverifiedUser.last).to eq(last_unverified_user)
  end
end
