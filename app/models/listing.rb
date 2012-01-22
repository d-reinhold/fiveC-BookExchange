require 'texticle/searchable'
class Listing < ActiveRecord::Base
  extend Searchable(:title, :author, :isbn)
  
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
                  
  attr_accessible :id, :user_id, :title, :price_dollars, :price_cents, :author, :edition, :isbn, :description, :condition, :book_id
  belongs_to :user
  belongs_to :book
  has_one :transaction, :dependent => :destroy
  
  before_save do
    self.isbn.gsub!('-','')
  end
  
  after_create do
    self.transaction ||= self.build_transaction
  end
  
  
  validates :title, :presence => true,
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
#  price_cents   :integer
#  description   :string(255)
#  condition     :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  book_id       :integer         default(-1)
#

