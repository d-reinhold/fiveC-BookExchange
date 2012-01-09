class CreateBooksCoursesTable < ActiveRecord::Migration
  def change
    create_table :books_courses, :id => false do |t|
      t.integer  :book_id
      t.integer :course_id
      t.timestamps
    end
    add_index :books_courses, :course_id
    add_index :books_courses, :book_id
    add_index :books_courses, [:book_id,:course_id], :unique => true
  end
end
