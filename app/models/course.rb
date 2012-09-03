# Encoding: utf-8
class Course < ActiveRecord::Base
  has_and_belongs_to_many :books
  belongs_to :school

  def autocomplete_display
    "#{self.department} #{self.number} #{self.school_symbol} — #{self.name} with #{self.prof}"
  end




end
# == Schema Information
#
# Table name: courses
#
#  id            :integer         not null, primary key
#  department    :string(255)
#  number        :string(255)
#  name          :string(255)
#  section       :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  prof          :string(255)
#  school_id     :integer
#  school_name   :string(255)
#  school_symbol :string(255)
#  semester      :string(255)
#

