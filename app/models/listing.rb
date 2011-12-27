class Listing < ActiveRecord::Base
  attr_accessible :id, :title, :price_dollars, :price_cents, :author, :edition, :isbn, :description, :condition
  belongs_to :user
  has_one :transaction
  
  after_initialize do
    self.transaction ||= self.build_transaction
  end
  
  
  validates :title, :presence => true,
                    :length => { :within => 1..100 }

  validates :price_dollars, :presence => true 
                            
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
#  price_cents   :integer
#  description   :string(255)
#  condition     :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

