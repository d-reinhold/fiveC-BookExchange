class RemoveNetworks < ActiveRecord::Migration
  def up
    drop_table :networks
  end

  def down
    create_table :networks do |t|
      t.string :name

      t.timestamps
    end
  end
end
