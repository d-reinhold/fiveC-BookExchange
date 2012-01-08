class AddIndexesToCourses < ActiveRecord::Migration
  def change
    execute "
        create index index_course_name on courses using gin(to_tsvector('english', name));
        create index index_course_prof on courses using gin(to_tsvector('english', prof));
        create index index_course_number on courses using gin(to_tsvector('english', number));
        create index index_course_department on courses using gin(to_tsvector('english', department));
        create index index_course_school on courses using gin(to_tsvector('english', school));"
  end
end
