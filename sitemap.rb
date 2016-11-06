require File.expand_path('../config/environment',  __FILE__)

if Rails.env == 'development'
  host = 'http://gtbitalumnilocal.in'
elsif Rails.env == 'staging'
  host = 'http://staging.gtbitalumni.in'
else
  host = 'https://gtbitalumni.in'
end

SitemapGenerator::Sitemap.default_host = host

SitemapGenerator::Sitemap.create do
  add '/posts/', :changefreq => 'daily'
  QuestionPost.all.each do |post|
    add "/posts/#{post.id}", :changefreq => 'daily'
  end

  add '/experience/', :changefreq => 'daily'
  ExperiencePost.all.each do |post|
    add "/experience/#{post.id}", :changefreq => 'daily'
  end

  add '/job/', :changefreq => 'daily'
  JobPost.all.each do |post|
    add "/job/#{post.id}", :changefreq => 'daily'
  end

  add '/user/', :changefreq => 'daily'
  User.all.each do |user|
    add "/user/#{user.id}", :changefreq => 'daily'
  end

  add '/users/sign_in', :changefreq => 'daily'
  add '/team', :changefreq => 'weekly'
end

SitemapGenerator::Sitemap.ping_search_engines if Rails.env != 'development'
