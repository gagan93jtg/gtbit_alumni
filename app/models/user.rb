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
  validates_numericality_of :experience_in_years, :greater_than_or_equal_to => 0,
  :less_than_or_equal_to => 100, :message => "is out of range. I hope you are a human being!"\
                                             " Now input a valid number to save."


  has_attached_file :avatar, styles: { large: "500x500>", thumb: "50x50>" },
                    :url => "users/avatars/:id/:style/avatar.:extension",
                    :path => "users/avatars/:id/:style/avatar.:extension"

  validates_with AttachmentSizeValidator, attributes: :avatar, less_than: 2.megabytes
  validates_attachment :avatar, content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }

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
           twitter_link: params[:twitter_link], linked_in_link: params[:linked_in_link])

    update(avatar: params[:avatar]) if params[:avatar]
  end

  def first_sign_in?
    sign_in_count == 1
  end

  def update_sign_in_count
    update(sign_in_count: 2)
  end

  # Not supporting cropping right now !
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
