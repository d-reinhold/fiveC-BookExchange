namespace :db do
  desc "Fixes small data issues in the Course and Book databases"
  task :cleanup_db => :environment do
    Book.all.each do |book|
      title = book.title
      if title.include?('&')
        puts title
        book.title = title.gsub('&','and')
        book.save!
        puts book.title
      end
    end
  end
end
