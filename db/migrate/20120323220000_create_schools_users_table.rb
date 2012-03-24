class CreateSchoolsUsersTable < ActiveRecord::Migration
  def change
    create_table :schools_users, :id => false do |t|
      t.integer :school_id
      t.integer :user_id
      t.timestamps
    end
    add_index :schools_users, :school_id
    add_index :schools_users, :user_id
    add_index :schools_users, [:school_id,:user_id], :unique => true
  end
end
