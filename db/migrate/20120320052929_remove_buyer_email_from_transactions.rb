class RemoveBuyerEmailFromTransactions < ActiveRecord::Migration
  def up
    remove_column :transactions, :buyer_email
    add_column :transactions, :buyer_id, :integer
    add_column :transactions, :seller_id, :integer
  end

  def down
    add_column :transactions, :buyer_email, :string
    remove_column :transactions, :buyer_id
    remove_column :transactions, :seller_id
  end
end
