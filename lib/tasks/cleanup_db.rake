namespace :db do
  desc "Run this after creating new schools and networks for Claremont"
  task :cleanup_db => :environment do
    pomona_id = School.where("name = ?", 'Pomona College').limit(1).first.id
    cmc_id = School.where("name = ?", 'Claremont McKenna College').limit(1).first.id
    hmc_id = School.where("name = ?", 'Harvey Mudd College').limit(1).first.id
    scripps_id = School.where("name = ?", 'Scripps College').limit(1).first.id
    pitzer_id = School.where("name = ?", 'Pitzer College').limit(1).first.id
    claremont_id = School.where("name = ?", 'Claremont Colleges').limit(1).first.id

    Course.all.each do |course|
      school_name = course.school_name
      case school_name
      when 'Pomona College'
        course.school_id = pomona_id
      when 'Claremont McKenna College'
        course.school_id = cmc_id
      when 'Harvey Mudd College'
        course.school_id = hmc_id
      when 'Scripps College'
        course.school_id = scripps_id
      when 'Pitzer College'
        course.school_id = pitzer_id
      else
        course.school_id = claremont_id
      end
      course.save
    end
  end
end
