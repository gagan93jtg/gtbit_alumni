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
    password = Utils.key_generator(10)
    user = User.create(first_name: first_name, last_name: last_name, email: email, password: password)
    unless user.errors.any?
      UserMailer.welcome_mail(user, password).deliver_now
      user.update_pass_in_redis(password)
      Rails.logger.info "Inviting : #{first_name} #{last_name} => #{email}"
    else
      Rails.logger.error "Errors while creating acc for #{email}. #{user.errors.full_messages.inspect}"
    end
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
