require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
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

