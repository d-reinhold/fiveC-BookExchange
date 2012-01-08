namespace :db do
  desc "Removes duplicate courses from the database"
  task :remove_dups => :environment do
    Course.all.each do |course|
    end
  end
end
