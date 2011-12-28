class TransactionMailer < ActionMailer::Base
  default from: "notifications@fivecbookexchange.herokuapp.com"
  
  
  def book_requested_seller(transaction)
    @transaction = transaction
    @seller = @transaction.listing.user
    @buyer_name = @transaction.buyer_name
    @buyer_email = @transaction.buyer_email
    @url  = "http://fivecbookexchange.herokuapp.com"
    email_with_name = "#{@seller.name} <#{@seller.email}>"
    mail(:to => email_with_name, :subject => "#{@buyer_name} wants to buy your book!")    
  end
  
  
  def book_requested_buyer(transaction)
    @transaction = transaction
    @seller = @transaction.listing.user
    @buyer_name = @transaction.buyer_name
    @buyer_email = @transaction.buyer_email
    @url  = "http://fivecbookexchange.herokuapp.com"
    email_with_name = "#{@buyer_name} <#{@buyer_email}>"
    mail(:to => email_with_name, :subject => "Your request on the 5C Book Exchange..")
  end
  
  def seller_cancelled_request_seller(transaction)
    @transaction = transaction
    @seller = @transaction.listing.user
    @buyer_name = @transaction.buyer_name
    @buyer_email = @transaction.buyer_email
    @url  = "http://fivecbookexchange.herokuapp.com"
    email_with_name = "#{@seller.name} <#{@seller.email}>"
    mail(:to => email_with_name, :subject => "You cancelled a request for your book.")
  end
  
  
  def seller_cancelled_request_buyer(transaction)
    @transaction = transaction
    @seller = @transaction.listing.user
    @buyer_name = @transaction.buyer_name
    @buyer_email = @transaction.buyer_email
    @url  = "http://fivecbookexchange.herokuapp.com"
    email_with_name = "#{@buyer_name} <#{@buyer_email}>"
    mail(:to => email_with_name, :subject => "Book request cancelled on the 5C Book Exchange.")
  end

  def buyer_cancelled_request_seller(transaction)
    @transaction = transaction
    @seller = @transaction.listing.user
    @buyer_name = @transaction.buyer_name
    @buyer_email = @transaction.buyer_email
    @url  = "http://fivecbookexchange.herokuapp.com"
    email_with_name = "#{@seller.name} <#{@seller.email}>"
    mail(:to => email_with_name, :subject => "Request for your book cancelled on the 5C Book Exchange.")
  end
  
  def buyer_cancelled_request_buyer(transaction)
    @transaction = transaction
    @seller = @transaction.listing.user
    @buyer_name = @transaction.buyer_name
    @buyer_email = @transaction.buyer_email
    @url  = "http://fivecbookexchange.herokuapp.com"
    email_with_name = "#{@buyer_name} <#{@buyer_email}>"
    mail(:to => email_with_name, :subject => "Book request cancelled on the 5C Book Exchange.")
  end
  
  def book_sold_seller(transaction)
    @transaction = transaction
    @seller = @transaction.listing.user
    @buyer_name = @transaction.buyer_name
    @buyer_email = @transaction.buyer_email
    @url  = "http://fivecbookexchange.herokuapp.com"
    email_with_name = "#{@seller.name} <#{@seller.email}>"
    mail(:to => email_with_name, :subject => "Book sold on the 5C Book Exchange!")
  end  
  
  def book_sold_buyer(transaction)
    @transaction = transaction
    @seller = @transaction.listing.user
    @buyer_name = @transaction.buyer_name
    @buyer_email = @transaction.buyer_email
    @url  = "http://fivecbookexchange.herokuapp.com"
    email_with_name = "#{@buyer_name} <#{@buyer_email}>"
    mail(:to => email_with_name, :subject => "Book sale finalized on the 5C Book Exchange!")
  end
  
  
end
