class UserMailer < ApplicationMailer

  def deactivate_users(users)
    mail(to: users, subject: 'We are deactivating your account', cc: 'gagan@gtbitalumni.in')
  end

  def welcome_mail(user, password)
    @user = user
    @password = password
    mail(to: user.email, subject: 'Welcome to GTBIT Alumni Network')
  end

  def contact_us_mail(params)
    subject = 'Contact us (new message)'
    @msg = "Hello #{params['full_name']} [ #{params['email']} ]. We have received your message. #{params['message']}"
    mail(to: CONFIG['admin_email'] || 'admin@gtbitalumni.in', subject: subject, cc: params['email'])
  end

  def report_bug_mail(params)
    subject = 'Report bug (new message)'
    @msg = "Hello #{params['full_name']} [ #{params['email']} ]. We have received bug reported by you. #{params['problem']}"
    mail(to: CONFIG['admin_email'] || 'admin@gtbitalumni.in', subject: subject, cc: params['email'])
  end

  def signup_mail(params)
    Rails.logger.error "\n\n\nparams : #{params.inspect}\n\n\n"
    subject = 'Thanks for signing up @ GTBIT Alumni Network'
    email = params[:email]
    full_name = params[:first_name] + " " + params[:last_name]
    @msg = "Hello #{full_name}, We have recieved your request and will approve your account shortly. As we want "\
    "only GTBITians to be on this portal, verification is a manual process and might take a little longer."

    mail(to: email, subject: subject, bcc: CONFIG['admin_email'] || 'admin@gtbitalumni.in')
  end
end
