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
#  id          :integer         not null, primary key
#  listing_id  :integer
#  buyer_email :string(255)     default("not set")
#  buyer_name  :string(255)     default("not set")
#  status      :string(255)     default("available")
#  created_at  :datetime
#  updated_at  :datetime
#

