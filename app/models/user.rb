class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  # I also removed :registerable as I don't want a signup process here.

  devise :database_authenticatable,
  :recoverable, :rememberable, :trackable, :validatable
  has_many :posts
  has_many :job_posts
  has_many :comments
  has_many :post_histories

  validates :first_name, length: { maximum: 255 }
  validates :last_name, length: { maximum: 255 }
  validates :phone, length: { maximum: 255 }
  validates :gender, length: { maximum: 255 }
  validates :batch, length: { maximum: 255 }
  validates :job_type, length: { maximum: 255 }
  validates :designation, length: { maximum: 255 }
  validates :company, length: { maximum: 255 }
  validates :fb_link, length: { maximum: 255 }
  validates :twitter_link, length: { maximum: 255 }
  validates :linked_in_link, length: { maximum: 255 }
  validates :bio, length: { maximum: 65535, message: 'is out of range. We know you are awesome, '\
   'but unfortunately we can handle only a 65535 characters long bio' }
   validates :is_admin, inclusion: { in: [true, false] }
   validates :is_moderator, inclusion: { in: [true, false] }
   validates_numericality_of :experience_in_years, :greater_than_or_equal_to => 0,
   :less_than_or_equal_to => 100, :message => "is out of range. I hope you are a human being!"\
   " Now input a valid number to save."

   has_attached_file :avatar, styles: { large: "256x256>", thumb: "64x64>" },
   :url => "users/avatars/:id/:style/avatar.:extension",
   :path => "users/avatars/:id/:style/avatar.:extension"

   validates_with AttachmentSizeValidator, attributes: :avatar, less_than: 1.megabytes
   validates_attachment :avatar, content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }

   validates_presence_of :first_name, message: 'must be present'

  # attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

  # after_update :reprocess_avtar, if: :avtar_was_cropped?

  def full_name
    return email if first_name.nil? || last_name.nil?
    first_name + ' ' + last_name
  end

  def update_details(params)
    update(first_name: params[:first_name], last_name: params[:last_name],
     phone: params[:phone], gender: params[:gender], batch: params[:batch],
     job_type: params[:job_type], designation: params[:designation],
     company: params[:company], experience_in_years: params[:experience_in_years],
     bio: params[:bio], fb_link: params[:fb_link],
     twitter_link: params[:twitter_link], linked_in_link: params[:linked_in_link],
     github_link: params[:github_link])

    update(avatar: params[:avatar]) if params[:avatar]
  end

  def first_sign_in?
    sign_in_count == 1
  end

  def update_sign_in_count
    update(sign_in_count: 2)
  end

  def question_posts
    posts.where(post_type: Comment::POST_TYPE[:QUESTION])
  end

  def experience_posts
    posts.where(post_type: Comment::POST_TYPE[:EXPERIENCE])
  end

  def update_password(params)
    user = params[:user]
    return 'Missing required fields. Fields marked * are ' +
    'compulsory' unless Utils.params_have_all_keys?(user, [:current_password,
     :new_password, :confirm_new_password])

    # dont strip the text ! password may contain leading or trailing spaces
    old_password = user[:current_password]
    new_password = user[:new_password]
    confirm_new_password = user[:confirm_new_password]


    if self.valid_password?(old_password)
      if new_password == confirm_new_password
        self.password = new_password
        self.password_confirmation = confirm_new_password;
        if self.invalid?
          return self.errors.full_messages
        else
          self.save
          update_pass_in_redis(new_password)
          return 'Password Updated !'
        end
      else
        return 'New passwords do not match'
      end
    else
      return 'Invalid old password'
    end
  end

  def active_for_authentication?
    super and self.is_active
  end

  def self.create_user(first_name, last_name, email)
    password = Utils.key_generator(10)
    user = User.new(first_name: first_name, last_name: last_name, email: email, password: password)
    user.save
    unless user.errors.any?
      UserMailer.welcome_mail(user, password).deliver_now
      user.update_pass_in_redis(password)
      Rails.logger.info "[#{Time.now}] Inviting : #{first_name} #{last_name} => #{email}"
      return true
    else
      Rails.logger.error "[#{Time.now}] Errors while creating acc for #{email}. #{user.errors.full_messages.inspect}"
      return false
    end
  end

  def update_pass_in_redis(pass)
    redis = RedisConnection.initialize_redices[0]
    begin
      redis.hset("USER_P", "USER_#{id}", pass)
    rescue StandardError => e
      Rails.logger.error "Unable to save new pass in redis for user #{self.id}"
      Rails.logger.error "Error : #{e.inspect}"
    end
  end

  def update_preferences_for_user(params_user)
    weekly_mailer = params_user['receive_weekly_mailer'] unless params_user.nil?
    unless weekly_mailer.nil?
      update(receive_weekly_mailer: true)
    else
      update(receive_weekly_mailer: false)
    end

    true
  end

  def has_admin_role?
    return (is_admin == true || is_moderator == true)
  end

  def not_an_admin?
    !has_admin_role?
  end

  # Not supporting cropping right now !
  #
  # def get_avatar_resolution(style)
  #   @geometry ||= {}
  #   @geometry[style] = Paperclip::Geometry.from_file(avatar.path(style))
  # end
  #
  # private
  #
  # def avtar_was_cropped?
  #   !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  # end
  #
  # def reprocess_avtar
  #   avtar.reprocess!
  # end
end
