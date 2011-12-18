class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.integer :user_id
      t.string :title
      t.string :isbn
      t.float :price
      t.string :description
      t.string :condition

      t.timestamps
    end
  end
end
