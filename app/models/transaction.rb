class Transaction < ActiveRecord::Base
  attr_accessible :buyer_id, :seller_id
  belongs_to :listing
  #email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  before_validation(:on => :create) do
    self.buyer_id = -1
    self.seller_id = self.listing.user.id
  end
  
  
  
  
end
# == Schema Information
#
# Table name: transactions
#
#  id         :integer         not null, primary key
#  listing_id :integer
#  status     :string(255)     default("available")
#  sell_date  :string(255)     default("not sold")
#  created_at :datetime
#  updated_at :datetime
#  buyer_name :string(255)
#  buyer_id   :integer
#  seller_id  :integer
#

