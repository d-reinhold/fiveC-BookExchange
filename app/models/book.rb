class Book < ActiveRecord::Base
  has_and_belongs_to_many :courses
  has_many :listings
  has_many :requests

  def autocomplete_display
      "#{self.title} by #{self.author}"
  end
  
  
  def self.compute_requests(book_id)
    if book_id != -1
      requests = Request.where('book_id = ?', book_id) # find all requests for this book
      listings = Listing.where('book_id = ?', book_id) # find all listings for this book
      if requests.any?  # if there are any requests for this book
        listing_available = listings.select{|l| l.transaction.status == 'available'}.any?
        requests.each do |r|
          if listing_available
            r.status = 'available'
            book = self.find(book_id)
            RequestMailer.request_available(r,book).deliver
          else
            r.status = 'unavailable'
          end
          r.save
        end
      end
    end
  end

  def self.match_listing_to_book(listing)
    downcase_title = listing.title.downcase
    downcase_title_symbol = downcase_title.gsub('and', '&')
    downcase_author = '%'+listing.author.downcase.split(' ').last
    book = self.where("lower(title) = ? and lower(author) LIKE ?", downcase_title_symbol, downcase_author).limit(1).all
    if (book.nil? or book.empty?) and listing.isbn != ''
      book = self.where("isbn = ?", listing.isbn.gsub('-','')).limit(1).all
    end
    unless book.empty?
      puts 'Found a course that requires this book!'
      return book.first.id 
    else
      puts 'no Books match this listing'
      return -1
    end
  end

end




# == Schema Information
#
# Table name: books
#
#  id           :integer         not null, primary key
#  title        :string(255)
#  author       :string(255)
#  edition      :string(255)
#  isbn         :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  huntley_new  :string(255)
#  huntley_used :string(255)
#

