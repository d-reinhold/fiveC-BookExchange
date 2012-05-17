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
      case course.school_symbol
      when 'PO'
        course.school_id = claremont_colleges.id
        course.school_name = 'Pomona College'
      when 'CM'
        course.school_id = claremont_colleges.id
        course.school_name = 'Claremont McKenna College'
      when 'HM'
        course.school_id = claremont_colleges.id
        course.school_name = 'Harvey Mudd College'
      when 'SC'
        course.school_id = claremont_colleges.id
        course.school_name = 'Scripps College'
      when 'PZ'
        course.school_id = claremont_colleges.id
        course.school_name = 'Pitzer College'
      else
        course.school_id = claremont_colleges.id
        course.school_name = 'Claremont Colleges'
      end
      course.save
    end
  end
end