class Book < ActiveRecord::Base
  belongs_to :course
  has_many :listings
end
# == Schema Information
#
# Table name: books
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  author     :string(255)
#  edition    :string(255)
#  isbn       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  course_id  :integer
#

