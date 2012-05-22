# encoding: utf-8
require 'json'


namespace :db do
  desc "Task for fixing up database"
  task :fb_user_tests => :environment do
    test_user_data = JSON.parse("https://graph.facebook.com/APP_ID/accounts/test-users?
      installed=true
      &name=test1
      &locale=en_US
      &permissions=user_education_history
      &method=post
      &access_token=APP_ACCESS_TOKEN")
  

  end
end