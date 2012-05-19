class AddHuntleyPricesToBooks < ActiveRecord::Migration
  def change
    add_column :books, :huntley_new, :string
    add_column :books, :huntley_used, :string
  end
end
