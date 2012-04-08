namespace :db do
  desc "Run this on a fresh db with courses and books"
  task :prep_colleges_and_courses => :environment do
    
    claremont_colleges = School.create!(:name => 'Claremont Colleges')
    pomona = School.create!(:name => 'Pomona College')
    cmc = School.create!(:name => 'Claremont McKenna College')
    hmc = School.create!(:name => 'Harvey Mudd College')
    scripps = School.create!(:name => 'Scripps College')
    pitzer = School.create!(:name => 'Pitzer College')


    Course.all.each do |course|
      case course.school_name
      when 'Pomona College'
        course.school_id = claremont_colleges.id
      when 'Claremont McKenna College'
        course.school_id = claremont_colleges.id
      when 'Harvey Mudd College'
        course.school_id = claremont_colleges.id
      when 'Scripps College'
        course.school_id = claremont_colleges.id
      when 'Pitzer College'
        course.school_id = claremont_colleges.id
      else
        course.school_id = claremont_colleges.id
      end
      course.save
    end
  end
end