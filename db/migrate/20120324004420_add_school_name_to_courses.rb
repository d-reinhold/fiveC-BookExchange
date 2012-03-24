class AddSchoolNameToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :school_name, :string
  end
end
