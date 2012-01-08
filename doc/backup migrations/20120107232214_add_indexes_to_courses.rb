class AddIndexesToCourses < ActiveRecord::Migration
  def change
    execute "
        create index on courses using gin(to_tsvector('english', name));
        create index on courses using gin(to_tsvector('english', prof));
        create index on courses using gin(to_tsvector('english', number));
        create index on courses using gin(to_tsvector('english', department));
        create index on courses using gin(to_tsvector('english', school));"
  end
end
