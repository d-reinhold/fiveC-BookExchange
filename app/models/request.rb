class Request < ActiveRecord::Base
  attr_accessible :student_email, :student_name, :id, :book_id
  belongs_to :book
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :student_email, :presence => true
  validates :student_name, :presence => true
  validate :is_fivec_email

  def is_fivec_email
    if student_email.include?("@pomona.edu")
      errors.add(:student_email, " error: Please use '@mymail.pomona.edu'")  
    else
      unless (student_email.include?("@students.pitzer.edu")) or student_email.include?("@pomona.edu") or (student_email.include?("@mymail.pomona.edu")) or (student_email.include?("@scrippscollege.edu")) or (student_email.include?("@hmc.edu")) or (student_email.include?("@g.hmc.edu")) or (student_email.include?("@pitzer.edu")) or (student_email.include?("@cmc.edu") or (student_email == "not set"))
        errors.add(:student_email, "is not a valid 5C email address") 
      end
    end
  end
end
