class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer :book_id
      t.string :student_name
      t.string :student_email
      t.string :status

      t.timestamps
    end
  end
end
