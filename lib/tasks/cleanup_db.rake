namespace :db do
  desc "Fixes small data issues in the Course and Book databases"
  task :cleanup_db => :environment do
    Course.all.each do |course|
      name = course.name
      if name.include?('/')
        puts name
        course.name = name.gsub('/',' / ')
        course.save!
        puts course.name
      end
      if name.include?('&')
        puts name
        course.name = name.gsub('&','and')
        course.save!
        puts course.name
      end
    end
  end
end
