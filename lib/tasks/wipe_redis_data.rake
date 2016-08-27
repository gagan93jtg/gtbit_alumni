desc 'Delete all redis data (for DEV env only)'
task :wipe_redis_data => :environment do

  unless Rails.env == 'development'
    puts 'CAUTION : Only for development environment'
    exit
  end
  puts "[#{Time.current}] : Starting rake task"

  redis_master = RedisConnection.initialize_redices[0]
  users = User.all.ids
  users.each do |id|
    redis_master.del("UNREAD_NOTIFS:#{id}")
    redis_master.del("READ_NOTIFS:#{id}")
  end

  redis_master.del('EXPERIENCE_POSTS')
  redis_master.del('JOB_POSTS')

  puts "[#{Time.current}] : Completing rake task"
end
