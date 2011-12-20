class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.integer :user_id
      t.string :title
      t.string :isbn
      t.string :edition
      t.string :author
      t.integer :price_dollars
      t.integer :price_cents
      t.string :description
      t.string :condition
      t.timestamps
    end
  end
end
