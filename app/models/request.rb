class Request < ActiveRecord::Base
  attr_accessible :user_id, :book_id
  belongs_to :book
  belongs_to :user


end
# == Schema Information
#
# Table name: requests
#
#  id         :integer         not null, primary key
#  book_id    :integer
#  status     :string(255)
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#

