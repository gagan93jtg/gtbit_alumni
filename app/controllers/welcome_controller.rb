class WelcomeController < ApplicationController
  # This is important : authentication will be done for index action ONLY !!!!!
  # Take care while adding new actions in this controller
  before_filter :authenticate_user!, only: [:index]

  def index
    per_page = CONFIG['pagination_per_page'] || 10
    @your_activity = current_user.posts.order("id desc").first(per_page)
    @public_activity = Post.public_activity(current_user.id, per_page)
    @public_job_posts = JobPost.public_activity(current_user.id, per_page)
    @notice = Notice.where("updated_at > #{2.days.ago.to_i}").last
  end

  def contact_us_mail
    @response = Utils.params_have_all_keys?(params, [:full_name, :email, :message])
    UserMailer.contact_us_mail(params).deliver_now if @response == true

    respond_to do |format|
      format.js {}
    end
  end

  def report_bug
    @response = Utils.params_have_all_keys?(params, [:full_name, :email, :problem])
    UserMailer.report_bug_mail(params).deliver_now if @response == true

    respond_to do |format|
      format.js {}
    end
  end

  def request_account
    @response = UnverifiedUser.create_unverified_user(params[:user])
    puts "sending params for mailer : #{params[:user].inspect}"
    UserMailer.signup_mail(params[:user]).deliver_now if @response == 'Success'

    respond_to do |format|
      format.js {}
    end
  end

  def team
    @names = ['Gagandeep Singh', 'Ekaspreet Singh', 'Mandeep Singh', 'Ishmeet Singh',
      'Ishaan Singh', 'Jagtar Singh Sir'];
    @profilePhotos = ["team/gagan.jpg", "team/ekas.jpg", "team/mandeep.jpg", "team/ishmeet.jpg",
       "team/ishaan.jpg",  "team/jagtar_sir.jpg"];
    @workInfo = ['Software Dev, Josh Technology Group', 'Software Dev, Nucleus', 'Security Enthusiast',
      'Software Dev, Royal Bank of Canada', 'Software Eng, HCL', 'Head  CDMC & Head Mechanical, GTBIT'];
    @designation = ['Backend Dev', 'Frontend Dev', 'Security', 'Visionary', 'Visionary', 'Supporting Faculty'];
    @fb_link = ['gagan93', 'Ekaspreetsingh', 'mandeepsingh.kapoor.984', 'ishmeetsingh.sethi', 'chawla.ishaan', 'jagtar.singh.370515'];
    @twitter_link = ['', 'handi_eddy', 'mandeeps13k', '', '', ''];
    @linked_in_link = ['gagan93', 'ekaspreetsingh', 'mandeep-singh-kapoor-566395110',
      'ishmeetsinghsethi', 'ishaan-singh-aa2b9370', ''];
    @fb_logo = "fb.png";
    @linked_in_logo = "linked_in.png";
    @twitter_logo = "twitter.png";
  end
end
