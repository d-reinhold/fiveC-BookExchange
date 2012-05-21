namespace :db do
  desc "Task for fixing up database"
  task :cleanup_db => :environment do
    school_names = {"PO" => "Pomona College", "CM" => "Claremont McKenna College", "SC" => "Scripps College", "PZ" => "Pitzer College", "HM" => "Harvey Mudd College", "KS" => "Claremont Colleges", "JP" => "Claremont Colleges", "JM" => "Claremont Colleges", "JT" => "Claremont Colleges", "AF" => "Claremont Colleges", "AA" => "Claremont Colleges", "CG" => "Claremont Colleges", "CH" => "Claremont Colleges" }
    #Course.all.each do |course|
    #  course.school_name = school_names[course.school_symbol]
    #  puts course.school_name
    #  course.save
    #end
    claremont_colleges = School.find_by_id(1)
    User.all.each do |user|
      unless user.schools.include?(claremont_colleges)
        user.schools << claremont_colleges
      end
    end

  end
end
