class AddBookIdToListings < ActiveRecord::Migration
  def change
    add_column :listings, :book_id, :integer, :default => -1
  end
end
