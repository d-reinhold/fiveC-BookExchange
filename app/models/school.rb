class School < ActiveRecord::Base
  has_and_belongs_to_many :users, :uniq => true
  has_many :courses
  has_many :listings
  
  validates :name, :presence => true

  
  
end
# == Schema Information
#
# Table name: schools
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

