class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation
  has_secure_password
  validates_presence_of :name
  validates_uniqueness_of :email
  validates_presence_of :password, :on => :create
  

end
