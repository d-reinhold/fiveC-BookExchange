class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation
  has_secure_password
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  #email_regex = /\A[\w+\-.]+@\A[/pomona.edu/ | /cmc.edu/]\z/i
  
  validates :name, :presence => true, 
                   :length => { :maximum => 50 }
  validates :email, :presence => true,
                    :format => { :with => email_regex },
                    :uniqueness => { :case_insensitive => true }
                    
  validates_presence_of :password, :on => :create,
                       :length => { :within => 6..40 }
                       
          
  has_many :listings

end
