class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :listing_id
      t.string :buyer_email, :default => "not set"
      t.string :buyer_name, :default => "not set"
      t.string :status, :default => "available"
      t.string :sell_date, :default => 'not sold'

      t.timestamps
    end
  end
end
