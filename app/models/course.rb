#require 'texticle/searchable'
class Course < ActiveRecord::Base
  has_and_belongs_to_many :books
  include PgSearch
  pg_search_scope :search_by_course_keywords, 
                  :against => [:school, :department, :name, :number, :prof],
                  :using => 
                    {
                      :tsearch => 
                      {
                        :prefix => true, 
                        :any_word => true,
                        :dictionary => "english"
                      }
                    }
          
    
  #extend Searchable(:school, :department, :name, :number, :prof)

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

