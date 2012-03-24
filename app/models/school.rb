class School < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_and_belongs_to_many :networks
  has_many :courses
  
  validates :name, :uniqueness => true
  validates :uid, :uniqueness => true
  
  
end
# == Schema Information
#
# Table name: schools
#
#  id         :integer         not null, primary key
#  uid        :string(255)
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

