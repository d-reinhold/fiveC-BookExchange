class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.string :number
      t.string :department
      t.string :school
      t.string :book_title
      t.string :book_author

      t.timestamps
    end
  end
end
