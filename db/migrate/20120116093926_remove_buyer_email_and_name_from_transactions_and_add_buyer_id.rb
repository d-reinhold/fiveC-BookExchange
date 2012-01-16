class RemoveBuyerEmailAndNameFromTransactionsAndAddBuyerId < ActiveRecord::Migration
  def up
    remove_column :transactions, :buyer_email
    remove_column :transactions, :buyer_name
    add_column :transactions, :buyer_id, :integer

  end

  def down
    add_column :transactions, :buyer_email, :string
    add_column :transactions, :buyer_name, :string
    remove_column :transactions, :buyer_id
  end
end
