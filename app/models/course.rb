require 'texticle/searchable'
class Course < ActiveRecord::Base
  has_many :books
  extend Searchable(:school, :department, :name, :number, :prof)

end
# == Schema Information
#
# Table name: courses
#
#  id         :integer         not null, primary key
#  school     :string(255)
#  department :string(255)
#  number     :string(255)
#  name       :string(255)
#  section    :string(255)
#  created_at :datetime
#  updated_at :datetime
#  prof       :string(255)
#

