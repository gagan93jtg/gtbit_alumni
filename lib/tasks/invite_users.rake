require 'csv'

desc 'Invite users from CSV'
task :invite_users => :environment do
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

    User.create_user(first_name, last_name, email)
  end
end
