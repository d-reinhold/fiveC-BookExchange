class Transaction < ActiveRecord::Base
  attr_accessible :buyer_email, :buyer_name, :id
  belongs_to :listing
  #email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  before_validation(:on => :create) do
    self.buyer_email = "not set"
    self.buyer_name = "not set"
  end
  
  validates :buyer_email, :presence => true#,
                    #:format => { :with => email_regex }
  validates :buyer_name, :presence => true
  #validate :is_fivec_email

=begin
  def is_fivec_email
    if buyer_email.include?("@pomona.edu")
      errors.add(:buyer_email, " error: Please use '@mymail.pomona.edu'")  
    else
      unless (buyer_email.include?("@students.pitzer.edu")) or buyer_email.include?("@pomona.edu") or (buyer_email.include?("@mymail.pomona.edu")) or (buyer_email.include?("@scrippscollege.edu")) or (buyer_email.include?("@hmc.edu")) or (buyer_email.include?("@g.hmc.edu")) or (buyer_email.include?("@pitzer.edu")) or (buyer_email.include?("@cmc.edu") or (buyer_email == "not set"))
        errors.add(:buyer_email, "is not a valid 5C email address") 
      end
    end
  end
=end 
  
  
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
#  sell_date   :string(255)     default("not sold")
#  created_at  :datetime
#  updated_at  :datetime
#

