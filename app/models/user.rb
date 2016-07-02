class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  # I also removed :registerable as I don't want a signup process here.
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :posts
  has_many :comments
  has_many :post_histories

  def full_name
    return email if first_name.nil? || last_name.nil?
    first_name + ' ' + last_name
  end

  def update_details(params)
    update(first_name: params[:first_name], last_name: params[:last_name],
           phone: params[:phone], gender: params[:gender], batch: params[:batch],
           job_type: params[:job_type], designation: params[:designation],
           company: params[:company], experience_in_years: params[:experience_in_years])
  end

  def first_sign_in?
    sign_in_count == 1
  end

  def update_sign_in_count
    update(sign_in_count: 2)
  end
end
