namespace :db do
  desc "Creates schools after courses and books"
  task :prep_colleges_and_courses => :environment do
    
    claremont_colleges = School.create!(:name => 'Claremont Colleges')
    pomona = School.create!(:name => 'Pomona College')
    cmc = School.create!(:name => 'Claremont McKenna College')
    hmc = School.create!(:name => 'Harvey Mudd College')
    scripps = School.create!(:name => 'Scripps College')
    pitzer = School.create!(:name => 'Pitzer College')


    Course.all.each do |course|
      course.school_id = claremont_colleges.id
      course.save
    end
  end
end