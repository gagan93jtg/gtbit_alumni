class UnverifiedUser < ActiveRecord::Base
  validates :first_name, length: { maximum: 255 }
  validates :last_name, length: { maximum: 255 }
  validates :email, length: { maximum: 255 }
  validates :batch, length: { maximum: 255 }

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :email

  def self.create_unverified_user(params)
    return 'Missing required fields. Fields marked * are ' +
           'compulsory' unless Utils.params_have_all_keys?(params, [:first_name, :last_name, :email])

    return 'Email id already in use' if email_id_already_in_use(params[:email])
    user = UnverifiedUser.new(first_name: params[:first_name].strip,
                              last_name: params[:last_name].strip, email: params[:email].strip,
                              batch: params[:batch].strip)
    if user.valid?
      user.save
      return 'Success'
    else
      return user.errors.full_messages
    end
  end

  def move_to_verified_user
    User.create_user(first_name, last_name, email)
    self.destroy
  end

  private

  # if email id already exists in User or UnverifiedUser models, return true otherwise false
  def self.email_id_already_in_use(email)
    return true unless User.find_by_email(email.strip).nil?

    return true unless UnverifiedUser.find_by_email(email.strip).nil?

    return false
  end
end
