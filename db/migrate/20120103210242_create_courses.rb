class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :school
      t.string :department
      t.string :number
      t.string :name
      t.string :section

      t.timestamps
    end
  end
end
