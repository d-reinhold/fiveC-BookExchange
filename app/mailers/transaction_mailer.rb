class TransactionMailer < ActionMailer::Base
  default from: "5C Book Exchange <fivecbookexchange@sendgrid.me>"
  
  
  def book_requested_seller(transaction)
    @transaction = transaction
    @seller = User.find(@transaction.seller_id)
    @buyer = User.find(@transaction.buyer_id)
    @url  = "http://www.5cbookexchange.com"
    email_with_name = "#{@seller.name} <#{@seller.email}>"
    mail(:to => email_with_name, :subject => "#{@buyer.name} wants to buy your book!")    
  end
  
  
  def book_requested_buyer(transaction)
    @transaction = transaction
    @seller = User.find(@transaction.seller_id)
    @buyer = User.find(@transaction.buyer_id)
    @url  = "http://www.5cbookexchange.com"
    email_with_name = "#{@buyer.name} <#{@buyer.email}>"
    mail(:to => email_with_name, :subject => "Your request on the 5C Book Exchange..")
  end
  
  def seller_cancelled_request_seller(transaction)
    @transaction = transaction
    @seller = User.find(@transaction.seller_id)
    @buyer = User.find(@transaction.buyer_id)
    @url  = "http://www.5cbookexchange.com"    
    email_with_name = "#{@seller.name} <#{@seller.email}>"
    mail(:to => email_with_name, :subject => "You cancelled a request for your book.")
  end
  
  def seller_cancelled_request_buyer(transaction)
    @transaction = transaction
    @seller = User.find(@transaction.seller_id)
    @buyer = User.find(@transaction.buyer_id)
    @url  = "http://www.5cbookexchange.com"
    email_with_name = "#{@buyer.name} <#{@buyer.email}>"
    mail(:to => email_with_name, :subject => "Book request cancelled on the 5C Book Exchange.")
  end

  def buyer_cancelled_request_seller(transaction)
    @transaction = transaction
    @seller = User.find(@transaction.seller_id)
    @buyer = User.find(@transaction.buyer_id)
    @url  = "http://www.5cbookexchange.com"
    email_with_name = "#{@seller.name} <#{@seller.email}>"
    mail(:to => email_with_name, :subject => "Request for your book cancelled on the 5C Book Exchange.")
  end
  
  def buyer_cancelled_request_buyer(transaction)
    @transaction = transaction
    @seller = User.find(@transaction.seller_id)
    @buyer = User.find(@transaction.buyer_id)
    @url  = "http://www.5cbookexchange.com"
    email_with_name = "#{@buyer.name} <#{@buyer.email}>"
    mail(:to => email_with_name, :subject => "Book request cancelled on the 5C Book Exchange.")
  end
  
  def book_sold_seller(transaction)
    @transaction = transaction
    @seller = User.find(@transaction.seller_id)
    @buyer = User.find(@transaction.buyer_id)
    @url  = "http://www.5cbookexchange.com"    
    email_with_name = "#{@seller.name} <#{@seller.email}>"
    mail(:to => email_with_name, :subject => "Book sold on the 5C Book Exchange!")
  end  
  
  def book_sold_buyer(transaction)
    @transaction = transaction
    @seller = User.find(@transaction.seller_id)
    @buyer = User.find(@transaction.buyer_id)
    @url  = "http://www.5cbookexchange.com"
    email_with_name = "#{@buyer.name} <#{@buyer.email}>"
    mail(:to => email_with_name, :subject => "Book sale finalized on the 5C Book Exchange!")
  end
  
  
end
