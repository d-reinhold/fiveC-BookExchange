class Transaction < ActiveRecord::Base
  attr_accessible :buyer_email, :buyer_name, :id
  belongs_to :listing
  validates :buyer_email, :presence => true
  validates :buyer_name, :presence => true
  #validates :status, :inclusion => [:in => ["available","unavailable"]]
  validate :is_fivec_email


  def is_fivec_email
    unless (buyer_email.include?("@pomona.edu")) or (buyer_email.include?("@mymail.pomona.edu")) or (buyer_email.include?("@scripps.edu")) or (buyer_email.include?("@hmc.edu")) or (buyer_email.include?("@pitzer.edu")) or (buyer_email.include?("@cmc.edu") or (buyer_email == "not set"))
      errors.add(:buyer_email, "is not a valid 5C email address") 
    end
  end
  

  
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

