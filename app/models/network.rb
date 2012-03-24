class Network < ActiveRecord::Base
  has_and_belongs_to_many :schools, :uniq => true
  has_many :users, :through => :schools, :uniq => true
  
  validates :name, :uniqueness => true
  
end
# == Schema Information
#
# Table name: networks
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

