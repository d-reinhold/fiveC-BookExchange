class AddCourseIdToBook < ActiveRecord::Migration
  def up
    add_column :books, :course_id, :integer
  end

  def down
    remove_column :books, :course_id
  end
end
