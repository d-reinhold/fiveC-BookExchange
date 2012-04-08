class RemoveCourseIdFromBooks < ActiveRecord::Migration
  def up
    remove_column :books, :course_id
  end

  def down
    add_column :books, :course_id, :integer
  end
end
