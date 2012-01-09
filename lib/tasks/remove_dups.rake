namespace :db do
  desc "Removes duplicate courses from the database"
  task :remove_dups => :environment do
    #Course.all.group_by('name').select{ |gr| gr.last.size > 1 }
  end
end
