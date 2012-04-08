class AddSchoolIdToListings < ActiveRecord::Migration
  def change
    add_column :listings, :school_id, :integer
  end
end
