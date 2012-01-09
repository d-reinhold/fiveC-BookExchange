class AddCourseIdToBook < ActiveRecord::Migration
  # This column is no longer necessary since books/courses are habtm. 
  # But i don't want to drop all my tables to erase this column! 
  # So ignore it!
  def up
    add_column :books, :course_id, :integer
  end

  def down
    remove_column :books, :course_id
  end
end
