class Listing < ActiveRecord::Base

  
=begin
  # HEROKU DOESN'T SUPPORT POSTGRES 8.4!!!!
  include PgSearch
  pg_search_scope :search_by_title, 
                  :against => :title,
                  :using => 
                    {:tsearch => {:prefix => true, :any_word => true}
                  }
  pg_search_scope :search_by_author, 
                  :against => :author,
                  :using => 
                    {:tsearch => {:prefix => true, :any_word => true}
                  }
  pg_search_scope :search_by_isbn, 
                  :against => :isbn,
                  :using => :tsearch        
=end
                  
  attr_accessible :id, :price_dollars, :price_cents, :condition, :book_id
  belongs_to :user
  belongs_to :book
  has_one :transaction, :dependent => :destroy
  
  after_create do
    self.transaction ||= self.build_transaction
  end


  validates :price_dollars, :numericality => { :greater_than_or_equal_to => 0, :only_integer => true }
  validates :price_cents, :presence => true
              
             

end
# == Schema Information
#
# Table name: listings
#
#  id            :integer         not null, primary key
#  user_id       :integer
#  price_dollars :integer
#  price_cents   :integer
#  condition     :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  book_id       :integer   
#

