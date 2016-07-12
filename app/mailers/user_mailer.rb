class UserMailer < ApplicationMailer

  def welcome_mail(user)
    mail(to: user.email, subject: "Welcome bitchwa").deliver
  end
end
