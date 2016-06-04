class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  # I also removed :registerable as I don't want a signup process here.
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :queries
  has_many :responses

  def full_name
    return self.first_name + " " + self.last_name
  end

  def update_details(params)
    self.update(:first_name => params[:first_name], :last_name => params[:last_name],
                :phone => params[:phone], :gender => params[:gender], :batch => params[:batch],
                :job_type => params[:job_type], :designation => params[:designation],
                :company => params[:company], :experience_in_years => params[:experience_in_years])
  end
end
