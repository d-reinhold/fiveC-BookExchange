class Transaction < ActiveRecord::Base
  attr_accessible :id
  belongs_to :listing
end
# == Schema Information
#
# Table name: transactions
#
#  id          :integer         not null, primary key
#  listing_id  :integer
#  status      :string(255)     default("available")
#  sell_date   :string(255)     default("not sold")
#  created_at  :datetime
#  updated_at  :datetime
#

