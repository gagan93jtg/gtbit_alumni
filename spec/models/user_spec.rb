require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryGirl.build :user }
  let(:admin) { FactoryGirl.build :admin }

  it 'will test password length validations' do
    user.password = ''
    expect(user).to be_invalid

    user.password = 'short'
    expect(user).to be_invalid

    user.password = 'atleast8charslong'
    expect(user).to be_valid
  end

  it 'will print full_name of user' do
    expect(user.full_name).to eq(user.first_name + " " + user.last_name)

    user.first_name = ''
    user.last_name = ''

    expect(user.full_name).to eq(user.email)
  end

  it 'will update user details' do
    user.update_details(first_name: 'Johnn', last_name: 'Do', phone: '123', gender: 'M',
      batch: 'abcd', job_type: 'Service', designation: 'SSD', company: 'ABC',
      experience_in_years: 5, bio: 'Cool guy',fb_link: 'cool_fb', twitter_link: 'cool_twitter',
      linked_in_link: 'cool_lil', github_link: 'cool_git')

    expect(user.first_name).to eq('Johnn')
    expect(user.last_name).to eq('Do')
    expect(user.phone).to eq('123')
    expect(user.gender).to eq('M')
    expect(user.batch).to eq('abcd')
    expect(user.job_type).to eq('Service')
    expect(user.designation).to eq('SSD')
    expect(user.company).to eq('ABC')
    expect(user.experience_in_years).to eq(5)
    expect(user.bio).to eq('Cool guy')
    expect(user.fb_link).to eq('cool_fb')
    expect(user.twitter_link).to eq('cool_twitter')
    expect(user.linked_in_link).to eq('cool_lil')
    expect(user.github_link).to eq('cool_git')
  end

  it 'will test db field length validations' do
    long_and_stupid_field = 'very long and stupid field crossing 255 characters' +
    'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod' +
    'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod' +
    'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod' +
    'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod' +
    'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod' +
    'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod'

    user.save
    user.update_details(first_name: long_and_stupid_field, last_name: long_and_stupid_field,
      phone: long_and_stupid_field, gender: long_and_stupid_field, batch: long_and_stupid_field,
      job_type: long_and_stupid_field, designation: long_and_stupid_field,
      company: long_and_stupid_field, experience_in_years: 1000000000000,
      fb_link: long_and_stupid_field, twitter_link: long_and_stupid_field,
      linked_in_link: long_and_stupid_field, github_link: long_and_stupid_field)
    user.reload

    expect(user.first_name).to eq('John')
    expect(user.last_name).to eq('Doe')
    expect(user.phone).to eq('')
    expect(user.gender).to eq('')
    expect(user.batch).to eq('')
    expect(user.job_type).to eq('')
    expect(user.designation).to eq('')
    expect(user.company).to eq('')
    expect(user.experience_in_years).to eq(0)
    expect(user.fb_link).to eq('')
    expect(user.twitter_link).to eq('')
    expect(user.linked_in_link).to eq('')
    expect(user.github_link).to eq('')
  end

  it 'will check if this is first sign in and update_sign_in_count' do
    expect(user.first_sign_in?).to be false

    user.update(sign_in_count: 1)
    expect(user.first_sign_in?).to be true

    # will make sign_in_count more than one so that welcome msg is not displayed
    user.update_sign_in_count
    expect(user.first_sign_in?).to be false
  end

  it 'will list user\'s question posts' do
    post = FactoryGirl.create(:question_post)
    post.user = user
    post.save

    expect(user.question_posts.first.query_string).to eq('This is a sample question post')
  end

  it 'will list user\'s experience posts' do
    post = FactoryGirl.create(:experience_post)
    post.user = user
    post.save

    expect(user.experience_posts.first.query_string).to eq('This is a sample experience post')
  end

  describe 'test password update functionality thoroughly' do
    let(:password_hash) { {current_password: '', new_password: '', confirm_new_password: ''} }

    it 'will simply return as required fields are not present' do
      return_msg = user.update_password(user: nil)
      expect(return_msg).to eq('Missing required fields. Fields marked * are compulsory')

      return_msg = user.update_password(user: {})
      expect(return_msg).to eq('Missing required fields. Fields marked * are compulsory')
    end

    it 'will send incorrect old password' do
      return_msg = user.update_password(user: password_hash)
      expect(return_msg).to eq('Missing required fields. Fields marked * are compulsory')

      password_hash[:current_password] = 'wrong_pass'
      password_hash[:new_password] = 'new_password'
      password_hash[:confirm_new_password] = 'confirm_new_password'

      return_msg = user.update_password(user: password_hash)
      expect(return_msg).to eq('Invalid old password')

      password_hash[:current_password] = 'atleast8charslongpassword'
      # from where did I get this ? From user factory

      return_msg = user.update_password(user: password_hash)
      expect(return_msg).to eq('New passwords do not match')

      password_hash[:confirm_new_password] = 'new_password'

      return_msg = user.update_password(user: password_hash)
      expect(return_msg).to eq('Password Updated !')

      # validate new password is there in place
      expect(user.valid_password?(password_hash[:new_password])).to eq(true)

    end

    it 'will overflow max password length' do
      password_hash[:current_password] = 'atleast8charslongpassword'
      password_hash[:new_password] = 'moreeeeeeethaaaaaaaaaannnnnnnnnn72charssssssssssssslongggg' +
      'passwwwwwwwwooooooooorrrrrrdddddd'
      password_hash[:confirm_new_password] = password_hash[:new_password]

      return_msg = user.update_password(user: password_hash)
      expect(return_msg.first.include?('Password is too long')).to eq(true)
    end
  end

  it 'checks for activated/deactivated users' do
    expect(user.active_for_authentication?).to eq(true)

    user.is_active = false
    expect(user.active_for_authentication?).to eq(false)
  end

  it 'will create a new user from given params' do
    User.create_user('Johny', 'Doaa', 'johnydoaa@example.com')
  end

  it 'will not create a new user due to validation failures' do
    User.create_user('Johny', 'Doaa', 'moreeeeeeethaaaaaaaaaannnnnnnnnn72charssssssssssssslongggg' +
      'passwwwwwwwwooooooooorrrrrrdddddd')
  end

  it 'will update user preferences' do
    # will set field to false
    user.update_preferences_for_user({})

    # will set field to true
    user.update_preferences_for_user({'receive_weekly_mailer' => true })
  end

  it 'will test user role' do
    expect(user.not_an_admin?).to eq(true)

    expect(admin.has_admin_role?).to eq(true)
  end
end
