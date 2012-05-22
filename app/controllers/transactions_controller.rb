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
        @seller = User.find(@transaction.seller_id)
        @buyer = User.find(@transaction.buyer_id)
      end
    end
  end
  
  
  def request_book
    @transaction = Transaction.find(params[:id])
    if @transaction.nil?
      flash[:error] = "An error occured!"
      redirect_to '/'
    else
      if not signed_in?
        session[:fb_store_listing_url] = "/listings/#{@transaction.listing.id}"
        redirect_to '/auth/facebook/'
      else
        @transaction = Transaction.find(params[:id])
        puts @transaction.seller_id 
        puts current_user.id
        if @transaction.seller_id == current_user.id
          flash[:error] = "You can't buy a book that you are selling!"
          redirect_to '/'
        elsif @transaction.status == 'available'
          @transaction.buyer_id = current_user.id
          @transaction.buyer_name = current_user.name
          @transaction.status = "unavailable"
          @requests_for_this_book = @current_user.requests.select{|request| request.book_id == @transaction.listing.book_id}
          if @requests_for_this_book.any?
            puts "You're trying to buy a book you've requested previously!"
            @requests_for_this_book.each{|request| request.destroy }
          end
            
          if @transaction.save
            TransactionMailer.book_requested_buyer(@transaction).deliver
            TransactionMailer.book_requested_seller(@transaction).deliver
            flash[:success] = "Transaction initiated! Check your email for more information."
            redirect_to @current_user
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
      @transaction.buyer_id = -1
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
      @transaction = Transaction.find(params[:id])
      unless (@current_user.id == @transaction.buyer_id) or (@current_user.id == @transaction.seller_id)
        redirect_to '/', :notice => "You don't have permission to view that page!"
      end
    end
    
    def seller
      @transaction = Transaction.find(params[:id])
      redirect_to '/', :notice => "You don't have permission to view that page!" unless @current_user.id == @transaction.seller_id
    end
        
end
