require 'date'
class TransactionsController < ApplicationController

  before_filter :authenticate_user, :only => [:show, :cancel_request, :sold] 
  before_filter :buyer_or_seller, :only => [:show, :cancel_request]
  before_filter :seller, :only => [:sold]
  
  
  def show
    unless Transaction.exists?(:id => params[:id])
      flash[:error] = 'That transaction does not exist.'
      redirect_to root_path
    else
      @transaction = Transaction.find(params[:id])
      if @transaction.status == 'available'
        flash[:error] = "You don't have permission to view that page."
        redirect_to @current_user
      else
        @title = 'Transactions'
        @listing = @transaction.listing
      end
    end
  end
  
  
  def request_book
    puts params
    @transaction = Transaction.find(params[:id])
    if @transaction.status == 'available'
      @transaction.buyer_email = params[:buyer_email]
      @transaction.buyer_name = params[:buyer_name]
      @transaction.status = "unavailable"
      if @transaction.save
        TransactionMailer.book_requested_buyer(@transaction).deliver
        TransactionMailer.book_requested_seller(@transaction).deliver
        flash[:success] = "Transaction initiated! Check your email for more information."
        if signed_in?
          redirect_to @current_user
        else
          redirect_to root_path
        end
      else
        message = @transaction.errors.full_messages
        flash[:error] = message
        redirect_to @transaction.listing
      end
    else 
      flash[:error] = "That listing is no longer available."
      redirect_to root_path
    end
  end

  def cancel_request
    puts params
    @transaction = Transaction.find(params[:id])
    if @transaction.status == 'unavailable'
      if @current_user.id == @transaction.listing.user.id
        TransactionMailer.seller_cancelled_request_seller(@transaction).deliver
        TransactionMailer.seller_cancelled_request_buyer(@transaction).deliver
      else
        TransactionMailer.buyer_cancelled_request_seller(@transaction).deliver
        TransactionMailer.buyer_cancelled_request_buyer(@transaction).deliver        
      end
      @transaction.buyer_email = 'not set'
      @transaction.buyer_name = 'not set'
      @transaction.status = 'available'
      if @transaction.save
        flash[:success] = "Transaction cancelled."
        redirect_to @current_user
      else
        message = @transaction.errors.full_messages
        flash[:error] = message
        redirect_to @current_user
      end
    else 
      flash[:error] = "That listing is not currently requested."
      redirect_to root_path
    end 
  end
  

  def sold
    puts params
    @transaction = Transaction.find(params[:id])
    if @transaction.status == 'unavailable'
      @transaction.status = 'sold'
      @transaction.sell_date = Date.today
      if @transaction.save
        TransactionMailer.book_sold_buyer(@transaction).deliver
        TransactionMailer.book_sold_seller(@transaction).deliver
        flash[:success] = "Transaction complete! Thanks for selling your book on the 5C Book Exchange!"
          redirect_to @current_user
      else
        message = @transaction.errors.full_messages
        flash[:error] = message
        redirect_to root_path
      end
    else 
      flash[:error] = "That listing is not currently requested."
      redirect_to root_path
    end 
  end
 
  private


    def buyer_or_seller
      if is_buyer? or is_seller?
        return true
      else
        redirect_to '/', :notice => "You don't have permission to view that page!"
      end
    end
    
    def seller
      redirect_to '/', :notice => "You don't have permission to view that page!" unless is_seller?
    end
        
    def is_buyer?
      @transaction = Transaction.find(params[:id])
      @transaction.buyer_email == @current_user.email ? true : false
    end
    
    def is_seller?
      @transaction = Transaction.find(params[:id])
      @listing = @transaction.listing
      @current_user.listings.each do |l|
        if l.id == @listing.id
          return true
        end
      end
      return false
    end
end
