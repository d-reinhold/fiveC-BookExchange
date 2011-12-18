class Listing < ActiveRecord::Base
  attr_accessible :title, :isbn, :price, :description, :condition
  
  validates_presence_of :title
  validates_presence_of :isbn
  validates_presence_of :price
  validates_presence_of :description
  validates_presence_of :condition
  
  belongs_to :user
end
