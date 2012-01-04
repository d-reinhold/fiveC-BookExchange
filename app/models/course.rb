class Course < ActiveRecord::Base
  has_many :books
end
