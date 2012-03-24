class RemoveSchoolFromCourses < ActiveRecord::Migration
  def up
    remove_column :courses, :school
  end

  def down
    add_column :courses, :school, :string
  end
end
