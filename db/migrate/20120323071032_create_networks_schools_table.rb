class CreateNetworksSchoolsTable < ActiveRecord::Migration
  def change
    create_table :networks_schools, :id => false do |t|
      t.integer :network_id
      t.integer :school_id
      t.timestamps
    end
    add_index :networks_schools, :network_id
    add_index :networks_schools, :school_id
    add_index :networks_schools, [:school_id,:network_id], :unique => true
  end
end
