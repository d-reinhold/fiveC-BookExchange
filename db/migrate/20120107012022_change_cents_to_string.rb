class ChangeCentsToString < ActiveRecord::Migration
  def up
    remove_column :listings, :price_cents
    add_column :listings, :price_cents, :string, :default => '00'
  end

  def down
    remove_column :listings, :price_cents
    add_column :listings, :price_cents, :integer
  end
end
