namespace :db do
  desc "First print all the professors' names, then put them in proper order"
  task :reverse_prof_names => :environment do
    Course.all.each do |course|
      #puts '*---------------*'
      puts course.department
      unless course.prof == 'Staff'
        #puts course.prof
        if course.prof.include?(';')
          #profs = course.prof.gsub('Jr.','').split(';')
          #course.prof =  profs[0].split(',').reverse.join(' ').gsub(',','').strip + ' and ' + profs[1].split(',').reverse.join(' ').gsub(',','').gsub('  ', ' ').strip
        else
          #course.prof = course.prof.gsub('Jr.','').split(',').reverse.join(' ').gsub(',','').strip
        end
        #course.save
      end
    end
  end
end
