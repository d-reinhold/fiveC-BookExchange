class RemoveFbSchoolsAndAddDefaultNetworkToUsers < ActiveRecord::Migration
  def up
    remove_column :users, :fb_colleges
    add_column :users, :current_network, :string
  end

  def down
    add_column :users, :fb_colleges, :text
    remove_column :users, :current_network
  end
end
