require 'test_helper'

class ListingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
# == Schema Information
#
# Table name: listings
#
#  id            :integer         not null, primary key
#  user_id       :integer
#  title         :string(255)
#  isbn          :string(255)
#  edition       :string(255)
#  author        :string(255)
#  price_dollars :integer
#  description   :string(255)
#  condition     :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  book_id       :integer         default(-1)
#  price_cents   :string(255)     default("00")
#  school_id     :integer
#  sell_date     :string(255)
#  status        :string(255)
#  buyer_id      :integer
#  buyer_name    :string(255)
#

