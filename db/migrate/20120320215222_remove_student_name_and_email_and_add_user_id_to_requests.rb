class RemoveStudentNameAndEmailAndAddUserIdToRequests < ActiveRecord::Migration
  def up
    remove_column :requests, :student_email
    remove_column :requests, :student_name
    add_column :requests, :user_id, :integer
  end

  def down
    add_column :requests, :student_email, :string
    add_column :requests, :student_name, :string
    remove_column :requests, :user_id
  end
end
