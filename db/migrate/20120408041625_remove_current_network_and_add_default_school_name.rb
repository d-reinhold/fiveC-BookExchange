class RemoveCurrentNetworkAndAddDefaultSchoolName < ActiveRecord::Migration
  def up
    remove_column :users, :current_network
    add_column :users, :default_school_name, :string
    add_column :users, :default_school_id, :integer
  end

  def down
    add_column :users, :current_network, :string
    remove_column :users, :default_school_name
    remove_column :users, :default_school_id
  end
end
