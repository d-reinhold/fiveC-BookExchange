class TransactionsController < ApplicationController
  before_filter :authenticate_user, :only => [:show, :cancel_request] 
  before_filter :correct_user, :only => [:show, :cancel_request]
  
  
  def show
    @title = 'Transactions'
    @transaction = Transaction.find(params[:id])
    @listing = @transaction.listing
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
 
  private

    def correct_user
      @transaction = Transaction.find(params[:id])
      @listing = @transaction.listing
      puts @listing.id
      @current_user.listings.each do |l|
        puts l.id
        if l.id == @listing.id
          return
        end
      end
      redirect_to '/', :notice => "You don't have permission to view that page!"
    end

end
