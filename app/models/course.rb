class Course < ActiveRecord::Base
  has_and_belongs_to_many :books
  belongs_to :school

  def autocomplete_display
    case self.school
    when 'PO'
      college = 'Pomona'
    when 'CM'
      college = 'CMC'
    when 'HM'
      college = 'Harvey Mudd'
    when 'SC'
      college = 'Scripps'
    when 'PZ'
      college = 'Pitzer'
    when 'JS'
      college = 'Joint Sciences'
    when 'AF'
      college = 'Africana Studies'
    else
      college = self.school
    end
    "#{self.name} with #{self.prof} at #{college}"
  end




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
#  school_id  :integer
#

