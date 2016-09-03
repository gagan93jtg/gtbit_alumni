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
  CSV.foreach("#{Rails.root}/public/invites/#{ARGV[1]}", :headers => true) do |row|
    first_name, last_name = row[0].split
    email = row[1]
    if email.nil? || email.strip.empty?
      log("Skipping #{first_name} #{last_name} as no email id ")
      next
    end
    first_name.capitalize! unless first_name.nil?
    last_name.capitalize! unless last_name.nil?
    last_name = ' ' if last_name.nil?

    password = Utils.key_generator(10)
    user = User.create(first_name: first_name, last_name: last_name, email: email, password: password)
    unless user.errors.any?
      UserMailer.welcome_mail(user, password).deliver_now
      user.update_pass_in_redis(password)
      puts "Inviting : #{first_name} #{last_name} => #{email}"
    else
      puts "Errors while creating acc for #{email}. #{user.errors.full_messages.inspect}"
    end
  end
  puts "[#{Time.current}] : Completing rake task"
end
