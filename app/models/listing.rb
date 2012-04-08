class Listing < ActiveRecord::Base
                
  attr_accessible :id, :user_id, :title, :price_dollars, :price_cents, :author, :edition, :isbn, :description, :condition, :book_id
  belongs_to :user
  belongs_to :book
  belongs_to :school
  has_one :transaction, :dependent => :destroy
  
  before_save do
    self.isbn.gsub!('-','')
  end
  
  after_create do
    self.transaction ||= self.build_transaction
  end
  
  
  validates :title, :presence => true,
                    :length => { :within => 1..100 }
  
  validates :author, :presence => true,
                    :length => { :within => 1..100 }

  validates :price_dollars, :numericality => { :greater_than_or_equal_to => 0, :only_integer => true }
  
                            
  validates :price_cents, :presence => true
              
             

end
# == Schema Information
#
# Table name: listings
#
#  id            :integer         not null, primary key
#  user_id       :integer
#  title         :string(255)
#  isbn          :string(255)
#  edition       :string(255)
#  author        :string(255)
#  price_dollars :integer
#  description   :string(255)
#  condition     :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  book_id       :integer         default(-1)
#  price_cents   :string(255)     default("00")
#  school_id     :integer
#

