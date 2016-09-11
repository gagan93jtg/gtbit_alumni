require File.expand_path('../../config/environment',  __FILE__)

User.create_user(ARGV[0], ARGV[1], ARGV[2])
