class User < ActiveRecord::Base
  serialize :fb_colleges
  has_many :listings, :dependent => :destroy
  has_many :requests
  attr_accessible :name, :email, :fb_colleges, :uid # PROTECT UID BEFORE PUBLIC LAUNCH!!
  
  validates :name, :presence => true, 
                   :length => { :maximum => 50 }
  validates :email, :presence => true,
                    :uniqueness => { :case_insensitive => true }        

  
  def self.create_with_omniauth(auth)
    create! do |user|
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.email = auth["info"]["email"]
    end
  end
  
  def update_with_omniauth(auth)
    self.name = auth["info"]["name"]
    self.email = auth["info"]["email"]
    schools = auth["extra"]["raw_info"]["education"]
    colleges = schools.each.select{|s| s["type"] == 'College'}
    college_names = Array.new
    colleges.each{|s| college_names << s["school"]["name"]}
    puts "College Names: #{college_names}"
    self.fb_colleges = college_names
    self.save
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

