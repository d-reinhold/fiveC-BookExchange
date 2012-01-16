class RemoveTitleAndAuthorAndIsbnAndEditionFromListings < ActiveRecord::Migration
  def up
    remove_column :listings, :title
    remove_column :listings, :author
    remove_column :listings, :isbn
    remove_column :listings, :edition
    remove_column :listings, :description
  end

  def down
    add_column :listings, :title, :string
    add_column :listings, :author, :string
    add_column :listings, :isbn, :string
    add_column :listings, :edition, :string
    add_column :listings, :description, :string
  end
end
