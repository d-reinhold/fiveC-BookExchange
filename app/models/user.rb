class User < ActiveRecord::Base
  has_many :listings, :dependent => :destroy
  accepts_nested_attributes_for :listings
  attr_accessible :name, :email, :password, :password_confirmation, :listings_attributes
  has_secure_password
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :name, :presence => true, 
                   :length => { :maximum => 50 }
  validates :email, :presence => true,
                    :format => { :with => email_regex },
                    :uniqueness => { :case_insensitive => true }
                  
  validates_presence_of :password, :on => :create,
                        :length => { :within => 6..40 }
            
  validate :is_fivec_email


  def is_fivec_email
    #if email.include?("@pomona.edu")
    #  errors.add(:email, "Please use '@mymail.pomona.edu'") 
    #else 
      unless (email.include?("@students.pitzer.edu")) or (email.include?("@mymail.pomona.edu")) or email.include?("@pomona.edu") or (email.include?("@scrippscollege.edu")) or (email.include?("@hmc.edu"))  or (email.include?("@g.hmc.edu")) or (email.include?("@pitzer.edu")) or (email.include?("@cmc.edu"))
        errors.add(:email, "is not a valid 5C email address")
      end
    #end
  end

end
# == Schema Information
#
# Table name: users
#
#  id              :integer         not null, primary key
#  email           :string(255)
#  name            :string(255)
#  password_digest :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

