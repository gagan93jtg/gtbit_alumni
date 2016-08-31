require 'csv'

desc 'Invite users from CSV'
task :invite_users => :environment do

  def log(str)
    puts "#{Time.current} #{str}"
  end

  def invite
  end

  puts "[#{Time.current}] : Starting rake task"

  redis_master = RedisConnection.initialize_redices[0]
  CSV.foreach("#{Rails.root}/public/invites/2013_cse.csv", :headers => true) do |row|
    first_name, last_name = row[0].split
    email = row[1]
    if email.nil? || email.strip.empty?
      log("Skipping #{first_name} #{last_name} as no email id ")
      next
    end
    first_name.capitalize! unless first_name.nil?
    last_name.capitalize! unless last_name.nil?

    password = Utils.key_generator(10)
    user = User.create(first_name: first_name, last_name: last_name, email: email, password: password)

    UserMailer.welcome_mail(user, password).deliver_now

    user.update_pass_in_redis(password)

    puts "Inviting : #{first_name} #{last_name} => #{email}"
  end

  puts "[#{Time.current}] : Completing rake task"

end
