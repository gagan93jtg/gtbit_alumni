class UserMailer < ApplicationMailer

  def welcome_mail(user)
    mail(to: user.email, subject: 'Welcome bitchwa').deliver
  end

  def contact_us_mail(params)
    subject = 'Contact us (new message)'
    @msg = "New message from #{params['full_name']} [ #{params['email']} ]. #{params['message']}"
    mail(to: CONFIG['dev_email'] || 'alumnigtbit@gmail.com', subject: subject).deliver
  end
end
