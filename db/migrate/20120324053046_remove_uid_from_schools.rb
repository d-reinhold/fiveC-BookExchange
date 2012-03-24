class RemoveUidFromSchools < ActiveRecord::Migration
  def up
    remove_column :schools, :uid
  end

  def down
    add_column :schools, :uid, :string
  end
end
