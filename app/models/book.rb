class Book < ActiveRecord::Base
  belongs_to :course
  has_many :listings
end
