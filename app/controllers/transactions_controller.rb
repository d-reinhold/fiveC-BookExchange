class TransactionsController < ApplicationController

  before_filter :authenticate_user, :only => [:show, :cancel_request, :sold] 
  before_filter :buyer_or_seller, :only => [:show, :cancel_request]
  before_filter :seller, :only => [:sold]
  
  
  def show
    @transaction = Transaction.find(params[:id])
    if @transaction.status == 'available'
      flash[:success] = "You don't have permission to view that page."
      redirect_to @current_user
    else
      @title = 'Transactions'
      @listing = @transaction.listing
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
        flash[:success] = "Transaction initiated! Check your email for more information."
        if signed_in?
          redirect_to @current_user
        else
          redirect_to root_path
        end
      else
        message = @transaction.errors.full_messages
        flash[:error] = message
        redirect_to root_path
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
      @transaction.buyer_email = 'not set'
      @transaction.buyer_name = 'not set'
      @transaction.status = 'available'
      if @transaction.save
        flash[:success] = "Transaction cancelled."
        if signed_in?
          redirect_to @current_user
        else
          redirect_to root_path
        end
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
  

  def sold
    puts params
    @transaction = Transaction.find(params[:id])
    if @transaction.status == 'unavailable'
      @transaction.status = 'sold'
      if @transaction.save
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
